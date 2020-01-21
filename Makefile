OBJCOPY := "$(shell which arm-elf-objcopy 2>/dev/null)"
ifeq (${OBJCOPY},"")
	OBJCOPY := arm-none-eabi-objcopy
endif

LAUNCHER_DIR = gpsp_launcher_src/elf
LAUNCHER = gpsp_launcher.tns
RESOURCES_DIR = gpsp_src/nspire
RESOURCES = gpsp_resources.tns

BINS = $(LAUNCHER) $(RESOURCES)

all: $(BINS)

.PHONY: $(LAUNCHER_DIR)/$(LAUNCHER)
$(LAUNCHER_DIR)/$(LAUNCHER):
	$(MAKE) -C $(LAUNCHER_DIR)

$(LAUNCHER): $(LAUNCHER_DIR)/$(LAUNCHER)
	$(OBJCOPY) -I binary -O binary $^ $@

.PHONY: $(RESOURCES_DIR)/$(RESOURCES)
$(RESOURCES_DIR)/$(RESOURCES):
	$(MAKE) -C $(RESOURCES_DIR)

$(RESOURCES): $(RESOURCES_DIR)/$(RESOURCES)
	$(OBJCOPY) -I binary -O binary $^ $@

.PHONY: clean
clean:
	$(MAKE) -C $(LAUNCHER_DIR) clean
	$(MAKE) -C $(RESOURCES_DIR) clean
