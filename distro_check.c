#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* debian_distro_ids[] = {
    "debian",
    "ubuntu",
    "linuxmint",
    "mx",
    "pop",
    "kali",
    "zorin",
    "elementary",
    "deepin",
    "antix",
    "sparky",
    "parrot",
    "devuan",
    "knoppix",
    "lmde",
    "tails",
    "pureos",
    "q4os"
};
const char* arch_based_distro_ids[]={
    "arch",
    "manjaro",
    "endeavouros",
    "garuda",
    "artix",
    "arcolinux",
    "blackarch",
    "cachyos",
};
int check_debian_distros (const char* distro){
    int array_size = sizeof(debian_distro_ids)/sizeof(debian_distro_ids[0]);
    for (int i = 0; i < array_size; i++){
        if (strcmp(distro,debian_distro_ids[i]))
            return 0;
    }
    return 1;
}
int check_arch_distros (const char* distro){
    int array_size = sizeof(arch_based_distro_ids)/sizeof(arch_based_distro_ids[0]);
    for (int i = 0; i < array_size; i++){
        if (strcmp(distro,arch_based_distro_ids[i]))
            return 0;
    }
    return 1;
}
int check_distros (const char* distro){
    if (check_debian_distros(distro) == 0)
        return 0;
    if (check_arch_distros(distro) == 0)
        return 1;
    return 2;
}
int main (int narg,char* argv[]){
    size_t x1 = strcspn(argv[2],"=");
    char distro_name[strlen(argv[2])-x1];
    strncpy(distro_name, argv[2]+x1+1,strlen(argv[2])-x1);
    switch (check_distros(distro_name))
    {
    case 0:
        printf("debian");
        break;
    case 1:
        printf("arch");
        break;
    default:
        printf("invalid distro\n");
        break;
    }
    return 0;
}