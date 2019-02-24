#!/bin/sh
ErroR(){
    echo installation failed >&2
    echo press enter to continue >&2
    read
    exit 1
}
swapon /mnt/base-us/SWAP # 不一定需要成功

feature_enabled(){
    return 1 # WIP
}
add_feature(){
    echo WIP >&2
    return 1
}

cd "$(dirname "$0")" || ErroR
. "distributions/$1" || ErroR

cd "$(pwd | sed 's|/us/|/base-us/|')" || ErroR
mkdir -p "$PWD/rootfs" || ErroR
rootfs_dir="$PWD/rootfs/${id}__${version}"
mkdir -p "/tmp/__KindleLinuxDeploy__" || ErroR
lockdir="/tmp/__KindleLinuxDeploy__/${id}__${version}"

FaiL(){
    post_install_failed
    echo installation failed >&2
    echo press enter to continue >&2
    read
    exit 1
}
if [ ! -d "$rootfs_dir" ] ;then
    mkdir "$rootfs_dir" || ErroR
    pre_install || FaiL
    TemP_TaR="$(mktemp)" # WARNING [TODO] Kindle的/tmp空間有時很可能不足
    rm "$TemP_TaR" || FaiL
    wget -O "$TemP_TaR" "$rootfs_url"
    [ $("${rootfs_sum_type}sum" "$TemP_TaR" | awk '{print $1}') = "${rootfs_sum_value}" ] || FaiL
    cd "$rootfs_dir" || FaiL
    case "$rootfs_type" in
        "tar.gz")
            tar -xvzf "$TemP_TaR" || FaiL
            rm "$TemP_TaR" || FaiL
            ;;
        *)
            FaiL
            ;;
    esac
    post_install || ErroR
fi

if [ ! -d "$lockdir" ] ;then
    mkdir "$lockdir" || FaiL
    mkdir "$lockdir/tmp" || FaiL
    cd "$rootfs_dir" || FaiL
    mount --bind /dev ./dev || ErroR
    mount --bind /dev/pts ./dev/pts || ErroR
    mount --bind /proc ./proc || ErroR
    mount --bind /sys ./sys || ErroR
    mount --bind "$lockdir/tmp" ./tmp || ErroR
fi

init_terminal

echo press enter to continue
read
exit 0
