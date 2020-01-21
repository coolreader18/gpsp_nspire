#include <os.h>
#include "elf.h"

#define FILENAME "gpsp_resources.tns"

static int is_elf(FILE* fp) {
    char magic[4];
    fread(magic, 1, 4, fp);
    return (memcmp("\x7f""ELF",magic,4) == 0);
}

int main(int argc, char *argv[]) {
    if (argc != 1 && argc != 2)
		return 0;
	
	int ret = 0;
	
	char path[256];
	strcpy(path, argv[0]);
	char* dir = strrchr(path,'/');
	strcpy(dir+1, FILENAME);
	
	
    FILE *fp = fopen(path, "rb");
    if (!fp) {
        show_msgbox("gpSP Loader","Could not open " FILENAME);
        return 0;
    }
	if (!is_elf(fp))
	{
		show_msgbox("gpSP Loader",FILENAME " is not a valid ELF file.");
		return 0;
	}
	
    if (elf_execute(fp, &ret, argc, (char*[]){ path, argv[1], NULL }))
	{
		show_msgbox("gpSP Loader","Failed to launch ELF file\nSanity check possibly failed");
	}
	fclose(fp);
    return ret;
}