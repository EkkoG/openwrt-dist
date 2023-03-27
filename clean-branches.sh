#!/bin/bash
#multiple line string
archs=$(cat <<-END
mips64_octeonplus
mips_24kc
mips_4kec
mips_mips32
mipsel_24kc
mipsel_24kc_24kf
mipsel_74kc
mipsel_mips32
x86_64
x86_64-21.02.5
aarch64_cortex-a53
aarch64_cortex-a72
aarch64_generic
arm_arm1176jzf-s_vfp
arm_arm926ej-s
arm_cortex-a15_neon-vfpv4
arm_cortex-a5_vfpv4
arm_cortex-a7
arm_cortex-a7_neon-vfpv4
arm_cortex-a7_vfpv4
arm_cortex-a8_vfpv3
arm_cortex-a9
arm_cortex-a9_neon
arm_cortex-a9_vfpv3-d16
arm_fa526
arm_mpcore
arm_xscale
i386_pentium-mmx
i386_pentium4
powerpc_464fp
powerpc_8540
END
)

all_braches=""
for arch in $archs; do
    all_braches="$all_braches packages/$arch-21.02"
    all_braches="$all_braches packages/$arch-22.03"
    all_braches="$all_braches packages/$arch-snapshot"
done

all_braches="$all_braches master rm"

all_remote_branches=$(git branch -a | grep remotes/origin | sed 's/remotes\/origin\///')
function check_exist() {
    for branch in $all_braches; do
        if [[ $branch == $1 ]]; then
            return 0
        fi
    done
    return 1
}
for remote_branch in $all_remote_branches; do
    check_exist $remote_branch
    if [[ $? == 1 ]]; then
        echo "delete $remote_branch"
        git push origin --delete $remote_branch
    fi
done