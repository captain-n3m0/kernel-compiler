#!/bin/bash
KERNEL_RELEASE=6.2
BUSYBOX_RELEASE=1.36.0
mkdir -p src
cd src
    
    #Kernel
    KERNEL_MAJOR_RELEASE=$(echo $KERNEL_RELEASE | sed 's/\([0-9]*\)[^0-9].*/\1/')
    wget https://mirrors.edge.kernel.org/pub/linux/kernel/v$KERNEL_MAJOR_RELEASE.x/linux-$KERNEL_RELEASE.tar.xz
    tar -xf linux-$KERNEL_RELEASE.tar.xz
    cd linux-$KERNEL_RELEASE
        make defconfig
        make -j16 || exit
    cd ..
    
    #Busybox
    wget https://busybox.net/downloads/busybox-$BUSYBOX_RELEASE.tar.bz2
    tar -xf busybox-$BUSYBOX_RELEASE.tar.bz2
    cd busybox=$BUSYBOX_RELEASE
        make defconfig
	sed 's/^.*CONFIG_STATIC[^_].*$/CONFIG_STATIC=y/g' -i .config
	make -j16 || exit
    cd ..
cd ..

cp src/linux-$KERNEL_RELEASE/arch/x86_64/boot/bzImage

#initrd
mkdir initrd
cd initrd
    mkdir -p bin dev proc sys
    cd bin
        cp ../../src/busybox-$BUSYBOX_RELEASE/busybox ./
	for progs in $(./busybox --list); do
            ln -s /bin/busybox ./$progs
	done
    cd ..

    echo '#!/bin/bash' > init
    echo 'mount -t sysfs sysfs /sys' >> init
    echo 'mount -t proc proc /proc' >> init
    echo 'mount -t devtmpfs udev /dev' >> init
    echo 'sysctl -w kernel.printk="2 4 1 7"' >> init
    echo 'clear' >> init
    echo 'bin/bash' >> init
    echo 'poweroff -f' >> init

    chmod -R 777 .

    find. | cpio -o -H newc > ../initrd.img

cd ..
