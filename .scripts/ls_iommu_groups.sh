#!/bin/bash
shopt -s nullglob
for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
    printf "IOMMU Group ${g##*/}:\n"
    for d in $g/devices/*; do
        printf "\t$(lspci -nns ${d##*/})\n"
    done;
done;
