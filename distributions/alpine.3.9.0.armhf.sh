arch=armv7l
id=alpine
version=3.9.0
rootfs_url=http://dl-cdn.alpinelinux.org/alpine/v3.9/releases/armhf/alpine-minirootfs-3.9.0-armhf.tar.gz
rootfs_type=tar.gz
rootfs_sum_type=sha256
rootfs_sum_value=5b1e6311cf5caff938d1ffb837f0c32b89306aa959c5a56cbf6f2c057861236
kernel_miniversion=2.6
#add_feature x11 install_x11
#add_feature x11/wm/xfce4 install_xfce4
#add_feature x11/wm/awesome install_awesome
#add_feature multiuser install_multiuser
install_x11(){
    echo WIP >&2
    return 1
}
install_xfce4(){
    echo WIP >&2
    return 1
}
install_awesome(){
    echo WIP >&2
    return 1
}
install_multiuser(){
    echo WIP >&2
    return 1
}
pre_install(){
:
}
post_install(){
:
}
post_install_failed(){
:
}
init_terminal(){
    if feature_enabled multiuser ;then
        echo WIP >&2
        return 1
    else
        chroot "$rootfs_dir" /bin/sh "$@"
    fi
}
init_x11(){
    echo WIP >&2
    return 1
}
