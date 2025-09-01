#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main (int narg,char* argv[]){
    size_t x1 = strcspn(argv[2],"=");
    char distro_name[strlen(argv[2])-x1];
    strncpy(distro_name, argv[2]+x1+1,strlen(argv[2])-x1);
    printf("Distro: %s",distro_name);

    return 0;
}