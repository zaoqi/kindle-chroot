#!/bin/sh
cd "$(dirname "$0")" || exit
real_kernel_version="$(uname -r)"
real_arch="$(uname -m)"
if [ -n "$KLD_ARCH" ] ;then
    real_arch="$KLD_ARCH"
fi
if [ -n "$KLD_KERNEL" ] ;then
    real_kernel_version="$KLD_KERNEL"
fi

# Normalize a version string for easy numeric comparisons
# c.f., https://stackoverflow.com/a/37939589 https://github.com/koreader/koreader/blob/master/platform/kindle/koreader.sh
version() { echo "$@" | awk -F. '{ printf("%d%03d%03d\n", $1,$2,$3); }'; }

make_a_dist_menu(){
. "distributions/$1" || exit
if [ "$(version "$real_kernel_version")" -ge "$(version "$kernel_miniversion")" ] && [ "$real_arch" = "$arch" ] ;then
cat > "run.${id}__${version}.kterm.sh" <<'EOF'
#!/bin/sh
cd "$(dirname "$0")" || exit
EOF
echo "/mnt/extensions/kterm/bin/kterm.sh -e \"\$0\"'/run-distribution.sh $1'" >> "run.${id}__${version}.kterm.sh"
chmod +x "run.${id}__${version}.kterm.sh"
cat <<EOF
{"name": "Run $id $version / kterm",
 "priority": 1,
 "action": "./run.${id}__${version}.kterm.sh"},
EOF
fi
}
cat > menu.json <<EOF
{
	"items": [
	{
		"name": "KindleLinuxDeploy",
		"priority": 0,
    "items": [
$(for dist in $(ls distributions) ;do # WARNING 有空格時有bug
make_a_dist_menu "$dist"
done)
        {"name": "RefreshMenu",
         "priority": 0,
         "action": "./refresh-menu.sh"}
    ]
}]}
EOF
