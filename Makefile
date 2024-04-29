TARGET = gw_retro_go

DEBUG = 0

OPT = -O2 -ggdb3

# To enable verbose, append VERBOSE=1 to make, e.g.:
# make VERBOSE=1
ifneq ($(strip $(VERBOSE)),1)
V = @
endif

ROMS_A7800 := $(filter-out roms/a7800/.keep, $(wildcard roms/a7800/*))
ROMS_AMSTRAD := $(filter-out roms/amstrad/.keep, $(wildcard roms/amstrad/*))
ROMS_GB := $(filter-out roms/gb/.keep, $(wildcard roms/gb/*))
ROMS_GW := $(filter-out roms/gw/.keep, $(wildcard roms/gw/*))
ROMS_MD := $(filter-out roms/md/.keep, $(wildcard roms/md/*))
ROMS_NES := $(filter-out roms/nes/.keep, $(wildcard roms/nes/*))
ROMS_MSX := $(filter-out roms/msx/.keep, $(wildcard roms/msx/*))
ROMS_PCE := $(filter-out roms/pce/.keep, $(wildcard roms/pce/*))
ROMS_VIDEOPAC := $(filter-out roms/videopac/.keep, $(wildcard roms/videopac/*))
ROMS_WSV := $(filter-out roms/wsv/.keep, $(wildcard roms/wsv/*))

ROMS_COL := $(filter-out roms/col/.keep, $(wildcard roms/col/*))
ROMS_GG := $(filter-out roms/gg/.keep, $(wildcard roms/gg/*))
ROMS_SG := $(filter-out roms/sg/.keep, $(wildcard roms/sg/*))
ROMS_SMS := $(filter-out roms/sms/.keep, $(wildcard roms/sms/*))

HOMEBREW_CELESTE := $(wildcard roms/homebrew/celeste.png roms/homebrew/Celeste.png)

######################################
# source
######################################
# C sources
C_SOURCES =  \
Core/Src/bilinear.c \
Core/Src/gw_buttons.c \
Core/Src/gw_flash.c \
Core/Src/gw_lcd.c \
Core/Src/gw_audio.c \
Core/Src/gw_malloc.c \
Core/Src/error_screens.c \
Core/Src/main.c \
Core/Src/save_manager.c \
Core/Src/sha256.c \
Core/Src/bq24072.c \
Core/Src/filesystem.c \
Core/Src/porting/lib/lzma/LzmaDec.c \
Core/Src/porting/lib/lzma/lzma.c \
Core/Src/porting/lib/hw_jpeg_decoder.c \
Core/Src/porting/lib/littlefs/lfs.c \
Core/Src/porting/lib/littlefs/lfs_util.c \
Core/Src/porting/common.c \
Core/Src/porting/odroid_audio.c \
Core/Src/porting/odroid_display.c \
Core/Src/porting/odroid_input.c \
Core/Src/porting/odroid_netplay.c \
Core/Src/porting/odroid_overlay.c \
Core/Src/porting/odroid_sdcard.c \
Core/Src/porting/odroid_system.c \
Core/Src/porting/crc32.c \
Core/Src/stm32h7xx_hal_msp.c \
Core/Src/stm32h7xx_it.c \
Core/Src/system_stm32h7xx.c

TAMP_DIR = Core/Src/porting/lib/tamp/tamp/_c_src/
TAMP_C_SOURCES = \
$(TAMP_DIR)/tamp/common.c \
$(TAMP_DIR)/tamp/compressor.c \
$(TAMP_DIR)/tamp/decompressor.c

# Add common C++ sources here
CXX_SOURCES = \
Core/Src/heap.cpp \

GNUBOY_C_SOURCES = 
TGBDUAL_C_SOURCES = 
TGBDUAL_CXX_SOURCES = 

ifeq ($(FORCE_GNUBOY),1)
ifneq ($(strip $(ROMS_GB)),)
GNUBOY_C_SOURCES += \
Core/Src/porting/gb/main_gb.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_cpu.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_debug.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_emu.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_hw.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_lcd.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_loader.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_mem.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_rtc.c \
retro-go-stm32/gnuboy-go/components/gnuboy/gnuboy_sound.c
endif
else
ifneq ($(strip $(ROMS_GB)),)
CORE_TGBDUAL = external/tgbdual-go

TGBDUAL_CXX_SOURCES += \
Core/Src/porting/gb_tgbdual/main_gb_tgbdual.cpp \
Core/Src/porting/gb_tgbdual/gw_renderer.cpp \
$(CORE_TGBDUAL)/gb_core/tgbdual_apu.cpp \
$(CORE_TGBDUAL)/gb_core/tgbdual_cheat.cpp \
$(CORE_TGBDUAL)/gb_core/tgbdual_cpu.cpp \
$(CORE_TGBDUAL)/gb_core/tgbdual_gb.cpp \
$(CORE_TGBDUAL)/gb_core/tgbdual_lcd.cpp \
$(CORE_TGBDUAL)/gb_core/tgbdual_mbc.cpp \
$(CORE_TGBDUAL)/gb_core/tgbdual_rom.cpp
endif
endif

NES_C_SOURCES = 

ifeq ($(FORCE_NOFRENDO),1)
ifneq ($(strip $(ROMS_NES)),)
NES_C_SOURCES += \
Core/Src/porting/nes/main_nes.c \
Core/Src/porting/nes/nofrendo_stm32.c \
retro-go-stm32/nofrendo-go/components/nofrendo/cpu/dis6502.c \
retro-go-stm32/nofrendo-go/components/nofrendo/cpu/nes6502.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map000.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map001.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map002.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map003.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map004.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map005.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map007.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map008.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map009.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map010.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map011.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map015.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map016.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map018.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map019.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map021.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map020.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map022.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map023.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map024.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map030.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map032.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map033.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map034.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map040.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map041.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map042.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map046.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map050.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map064.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map065.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map066.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map070.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map071.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map073.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map074.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map075.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map076.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map078.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map079.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map085.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map087.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map093.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map094.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map119.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map160.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map162.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map185.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map191.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map192.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map193.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map194.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map195.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map228.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map206.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map229.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map231.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map252.c \
retro-go-stm32/nofrendo-go/components/nofrendo/mappers/map253.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/nes_apu.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/game_genie.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/nes_input.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/nes_mem.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/nes_mmc.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/nes_ppu.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/nes_rom.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/nes_state.c \
retro-go-stm32/nofrendo-go/components/nofrendo/nes/nes.c
endif
else
NES_FCEU_C_SOURCES = 
ifneq ($(strip $(ROMS_NES)),)
CORE_FCEUMM = external/fceumm-go
NES_FCEU_C_SOURCES += \
Core/Src/porting/nes_fceu/main_nes_fceu.c \
$(CORE_FCEUMM)/src/boards/09-034a.c \
$(CORE_FCEUMM)/src/boards/3d-block.c \
$(CORE_FCEUMM)/src/boards/8in1.c \
$(CORE_FCEUMM)/src/boards/12in1.c \
$(CORE_FCEUMM)/src/boards/15.c \
$(CORE_FCEUMM)/src/boards/18.c \
$(CORE_FCEUMM)/src/boards/28.c \
$(CORE_FCEUMM)/src/boards/31.c \
$(CORE_FCEUMM)/src/boards/32.c \
$(CORE_FCEUMM)/src/boards/33.c \
$(CORE_FCEUMM)/src/boards/34.c \
$(CORE_FCEUMM)/src/boards/40.c \
$(CORE_FCEUMM)/src/boards/41.c \
$(CORE_FCEUMM)/src/boards/42.c \
$(CORE_FCEUMM)/src/boards/43.c \
$(CORE_FCEUMM)/src/boards/46.c \
$(CORE_FCEUMM)/src/boards/50.c \
$(CORE_FCEUMM)/src/boards/51.c \
$(CORE_FCEUMM)/src/boards/57.c \
$(CORE_FCEUMM)/src/boards/60.c \
$(CORE_FCEUMM)/src/boards/62.c \
$(CORE_FCEUMM)/src/boards/65.c \
$(CORE_FCEUMM)/src/boards/67.c \
$(CORE_FCEUMM)/src/boards/68.c \
$(CORE_FCEUMM)/src/boards/69.c \
$(CORE_FCEUMM)/src/boards/71.c \
$(CORE_FCEUMM)/src/boards/72.c \
$(CORE_FCEUMM)/src/boards/77.c \
$(CORE_FCEUMM)/src/boards/79.c \
$(CORE_FCEUMM)/src/boards/80.c \
$(CORE_FCEUMM)/src/boards/82.c \
$(CORE_FCEUMM)/src/boards/88.c \
$(CORE_FCEUMM)/src/boards/91.c \
$(CORE_FCEUMM)/src/boards/96.c \
$(CORE_FCEUMM)/src/boards/99.c \
$(CORE_FCEUMM)/src/boards/103.c \
$(CORE_FCEUMM)/src/boards/104.c \
$(CORE_FCEUMM)/src/boards/106.c \
$(CORE_FCEUMM)/src/boards/108.c \
$(CORE_FCEUMM)/src/boards/112.c \
$(CORE_FCEUMM)/src/boards/116.c \
$(CORE_FCEUMM)/src/boards/117.c \
$(CORE_FCEUMM)/src/boards/120.c \
$(CORE_FCEUMM)/src/boards/121.c \
$(CORE_FCEUMM)/src/boards/126-422-534.c \
$(CORE_FCEUMM)/src/boards/134.c \
$(CORE_FCEUMM)/src/boards/151.c \
$(CORE_FCEUMM)/src/boards/156.c \
$(CORE_FCEUMM)/src/boards/162.c \
$(CORE_FCEUMM)/src/boards/163.c \
$(CORE_FCEUMM)/src/boards/164.c \
$(CORE_FCEUMM)/src/boards/168.c \
$(CORE_FCEUMM)/src/boards/170.c \
$(CORE_FCEUMM)/src/boards/175.c \
$(CORE_FCEUMM)/src/boards/177.c \
$(CORE_FCEUMM)/src/boards/178.c \
$(CORE_FCEUMM)/src/boards/183.c \
$(CORE_FCEUMM)/src/boards/185.c \
$(CORE_FCEUMM)/src/boards/186.c \
$(CORE_FCEUMM)/src/boards/187.c \
$(CORE_FCEUMM)/src/boards/189.c \
$(CORE_FCEUMM)/src/boards/190.c \
$(CORE_FCEUMM)/src/boards/193.c \
$(CORE_FCEUMM)/src/boards/195.c \
$(CORE_FCEUMM)/src/boards/199.c \
$(CORE_FCEUMM)/src/boards/206.c \
$(CORE_FCEUMM)/src/boards/208.c \
$(CORE_FCEUMM)/src/boards/218.c \
$(CORE_FCEUMM)/src/boards/222.c \
$(CORE_FCEUMM)/src/boards/225.c \
$(CORE_FCEUMM)/src/boards/228.c \
$(CORE_FCEUMM)/src/boards/230.c \
$(CORE_FCEUMM)/src/boards/232.c \
$(CORE_FCEUMM)/src/boards/233.c \
$(CORE_FCEUMM)/src/boards/234.c \
$(CORE_FCEUMM)/src/boards/235.c \
$(CORE_FCEUMM)/src/boards/236.c \
$(CORE_FCEUMM)/src/boards/237.c \
$(CORE_FCEUMM)/src/boards/244.c \
$(CORE_FCEUMM)/src/boards/246.c \
$(CORE_FCEUMM)/src/boards/252.c \
$(CORE_FCEUMM)/src/boards/253.c \
$(CORE_FCEUMM)/src/boards/267.c \
$(CORE_FCEUMM)/src/boards/268.c \
$(CORE_FCEUMM)/src/boards/269.c \
$(CORE_FCEUMM)/src/boards/272.c \
$(CORE_FCEUMM)/src/boards/283.c \
$(CORE_FCEUMM)/src/boards/291.c \
$(CORE_FCEUMM)/src/boards/293.c \
$(CORE_FCEUMM)/src/boards/294.c \
$(CORE_FCEUMM)/src/boards/310.c \
$(CORE_FCEUMM)/src/boards/319.c \
$(CORE_FCEUMM)/src/boards/326.c \
$(CORE_FCEUMM)/src/boards/330.c \
$(CORE_FCEUMM)/src/boards/334.c \
$(CORE_FCEUMM)/src/boards/351.c \
$(CORE_FCEUMM)/src/boards/353.c \
$(CORE_FCEUMM)/src/boards/354.c \
$(CORE_FCEUMM)/src/boards/356.c \
$(CORE_FCEUMM)/src/boards/357.c \
$(CORE_FCEUMM)/src/boards/359.c \
$(CORE_FCEUMM)/src/boards/360.c \
$(CORE_FCEUMM)/src/boards/364.c \
$(CORE_FCEUMM)/src/boards/368.c \
$(CORE_FCEUMM)/src/boards/369.c \
$(CORE_FCEUMM)/src/boards/370.c \
$(CORE_FCEUMM)/src/boards/372.c \
$(CORE_FCEUMM)/src/boards/375.c \
$(CORE_FCEUMM)/src/boards/376.c \
$(CORE_FCEUMM)/src/boards/377.c \
$(CORE_FCEUMM)/src/boards/380.c \
$(CORE_FCEUMM)/src/boards/382.c \
$(CORE_FCEUMM)/src/boards/383.c \
$(CORE_FCEUMM)/src/boards/389.c \
$(CORE_FCEUMM)/src/boards/390.c \
$(CORE_FCEUMM)/src/boards/391.c \
$(CORE_FCEUMM)/src/boards/393.c \
$(CORE_FCEUMM)/src/boards/395.c \
$(CORE_FCEUMM)/src/boards/396.c \
$(CORE_FCEUMM)/src/boards/401.c \
$(CORE_FCEUMM)/src/boards/403.c \
$(CORE_FCEUMM)/src/boards/410.c \
$(CORE_FCEUMM)/src/boards/411.c \
$(CORE_FCEUMM)/src/boards/414.c \
$(CORE_FCEUMM)/src/boards/416.c \
$(CORE_FCEUMM)/src/boards/417.c \
$(CORE_FCEUMM)/src/boards/428.c \
$(CORE_FCEUMM)/src/boards/431.c \
$(CORE_FCEUMM)/src/boards/432.c \
$(CORE_FCEUMM)/src/boards/433.c \
$(CORE_FCEUMM)/src/boards/434.c \
$(CORE_FCEUMM)/src/boards/436.c \
$(CORE_FCEUMM)/src/boards/437.c \
$(CORE_FCEUMM)/src/boards/438.c \
$(CORE_FCEUMM)/src/boards/441.c \
$(CORE_FCEUMM)/src/boards/443.c \
$(CORE_FCEUMM)/src/boards/444.c \
$(CORE_FCEUMM)/src/boards/449.c \
$(CORE_FCEUMM)/src/boards/452.c \
$(CORE_FCEUMM)/src/boards/455.c \
$(CORE_FCEUMM)/src/boards/456.c \
$(CORE_FCEUMM)/src/boards/460.c \
$(CORE_FCEUMM)/src/boards/463.c \
$(CORE_FCEUMM)/src/boards/465.c \
$(CORE_FCEUMM)/src/boards/466.c \
$(CORE_FCEUMM)/src/boards/467.c \
$(CORE_FCEUMM)/src/boards/468.c \
$(CORE_FCEUMM)/src/boards/516.c \
$(CORE_FCEUMM)/src/boards/533.c \
$(CORE_FCEUMM)/src/boards/539.c \
$(CORE_FCEUMM)/src/boards/554.c \
$(CORE_FCEUMM)/src/boards/558.c \
$(CORE_FCEUMM)/src/boards/603-5052.c \
$(CORE_FCEUMM)/src/boards/8157.c \
$(CORE_FCEUMM)/src/boards/8237.c \
$(CORE_FCEUMM)/src/boards/411120-c.c \
$(CORE_FCEUMM)/src/boards/830118C.c \
$(CORE_FCEUMM)/src/boards/830134C.c \
$(CORE_FCEUMM)/src/boards/a9746.c \
$(CORE_FCEUMM)/src/boards/ac-08.c \
$(CORE_FCEUMM)/src/boards/addrlatch.c \
$(CORE_FCEUMM)/src/boards/ax40g.c \
$(CORE_FCEUMM)/src/boards/ax5705.c \
$(CORE_FCEUMM)/src/boards/bandai.c \
$(CORE_FCEUMM)/src/boards/bb.c \
$(CORE_FCEUMM)/src/boards/bj56.c \
$(CORE_FCEUMM)/src/boards/bmc42in1r.c \
$(CORE_FCEUMM)/src/boards/bmc64in1nr.c \
$(CORE_FCEUMM)/src/boards/bmc60311c.c \
$(CORE_FCEUMM)/src/boards/bmc80013b.c \
$(CORE_FCEUMM)/src/boards/bmc830425C4391t.c \
$(CORE_FCEUMM)/src/boards/bmcctc09.c \
$(CORE_FCEUMM)/src/boards/bmcgamecard.c \
$(CORE_FCEUMM)/src/boards/bmck3006.c \
$(CORE_FCEUMM)/src/boards/bmck3033.c \
$(CORE_FCEUMM)/src/boards/bmck3036.c \
$(CORE_FCEUMM)/src/boards/bmcl6in1.c \
$(CORE_FCEUMM)/src/boards/BMW8544.c \
$(CORE_FCEUMM)/src/boards/bonza.c \
$(CORE_FCEUMM)/src/boards/bs-5.c \
$(CORE_FCEUMM)/src/boards/cheapocabra.c \
$(CORE_FCEUMM)/src/boards/cityfighter.c \
$(CORE_FCEUMM)/src/boards/coolgirl.c \
$(CORE_FCEUMM)/src/boards/dance2000.c \
$(CORE_FCEUMM)/src/boards/datalatch.c \
$(CORE_FCEUMM)/src/boards/dream.c \
$(CORE_FCEUMM)/src/boards/edu2000.c \
$(CORE_FCEUMM)/src/boards/eeprom_93C66.c \
$(CORE_FCEUMM)/src/boards/eh8813a.c \
$(CORE_FCEUMM)/src/boards/et-100.c \
$(CORE_FCEUMM)/src/boards/et-4320.c \
$(CORE_FCEUMM)/src/boards/f-15.c \
$(CORE_FCEUMM)/src/boards/fceu-emu2413.c \
$(CORE_FCEUMM)/src/boards/famicombox.c \
$(CORE_FCEUMM)/src/boards/faridunrom.c \
$(CORE_FCEUMM)/src/boards/ffe.c \
$(CORE_FCEUMM)/src/boards/fk23c.c \
$(CORE_FCEUMM)/src/boards/gn26.c \
$(CORE_FCEUMM)/src/boards/h2288.c \
$(CORE_FCEUMM)/src/boards/hp10xx_hp20xx.c \
$(CORE_FCEUMM)/src/boards/hp898f.c \
$(CORE_FCEUMM)/src/boards/jyasic.c \
$(CORE_FCEUMM)/src/boards/karaoke.c \
$(CORE_FCEUMM)/src/boards/KG256.c \
$(CORE_FCEUMM)/src/boards/kof97.c \
$(CORE_FCEUMM)/src/boards/KS7012.c \
$(CORE_FCEUMM)/src/boards/KS7013.c \
$(CORE_FCEUMM)/src/boards/KS7016.c \
$(CORE_FCEUMM)/src/boards/KS7017.c \
$(CORE_FCEUMM)/src/boards/KS7030.c \
$(CORE_FCEUMM)/src/boards/KS7031.c \
$(CORE_FCEUMM)/src/boards/KS7032.c \
$(CORE_FCEUMM)/src/boards/KS7037.c \
$(CORE_FCEUMM)/src/boards/KS7057.c \
$(CORE_FCEUMM)/src/boards/le05.c \
$(CORE_FCEUMM)/src/boards/lh32.c \
$(CORE_FCEUMM)/src/boards/lh51.c \
$(CORE_FCEUMM)/src/boards/lh53.c \
$(CORE_FCEUMM)/src/boards/malee.c \
$(CORE_FCEUMM)/src/boards/mihunche.c \
$(CORE_FCEUMM)/src/boards/mmc1.c \
$(CORE_FCEUMM)/src/boards/mmc2and4.c \
$(CORE_FCEUMM)/src/boards/mmc3.c \
$(CORE_FCEUMM)/src/boards/mmc5.c \
$(CORE_FCEUMM)/src/boards/n106.c \
$(CORE_FCEUMM)/src/boards/n625092.c \
$(CORE_FCEUMM)/src/boards/novel.c \
$(CORE_FCEUMM)/src/boards/onebus.c \
$(CORE_FCEUMM)/src/boards/pec-586.c \
$(CORE_FCEUMM)/src/boards/resetnromxin1.c \
$(CORE_FCEUMM)/src/boards/resettxrom.c \
$(CORE_FCEUMM)/src/boards/rt-01.c \
$(CORE_FCEUMM)/src/boards/SA-9602B.c \
$(CORE_FCEUMM)/src/boards/sachen.c \
$(CORE_FCEUMM)/src/boards/sheroes.c \
$(CORE_FCEUMM)/src/boards/sl1632.c \
$(CORE_FCEUMM)/src/boards/subor.c \
$(CORE_FCEUMM)/src/boards/super40in1.c \
$(CORE_FCEUMM)/src/boards/supervision.c \
$(CORE_FCEUMM)/src/boards/t-227-1.c \
$(CORE_FCEUMM)/src/boards/t-262.c \
$(CORE_FCEUMM)/src/boards/tengen.c \
$(CORE_FCEUMM)/src/boards/tf-1201.c \
$(CORE_FCEUMM)/src/boards/transformer.c \
$(CORE_FCEUMM)/src/boards/txcchip.c \
$(CORE_FCEUMM)/src/boards/unrom512.c \
$(CORE_FCEUMM)/src/boards/vrc1.c \
$(CORE_FCEUMM)/src/boards/vrc2and4.c \
$(CORE_FCEUMM)/src/boards/vrc3.c \
$(CORE_FCEUMM)/src/boards/vrc6.c \
$(CORE_FCEUMM)/src/boards/vrc7.c \
$(CORE_FCEUMM)/src/boards/vrc7p.c \
$(CORE_FCEUMM)/src/boards/yoko.c \
$(CORE_FCEUMM)/src/cheat.c \
$(CORE_FCEUMM)/src/fceu-cart.c \
$(CORE_FCEUMM)/src/fceu-endian.c \
$(CORE_FCEUMM)/src/fceu-memory.c \
$(CORE_FCEUMM)/src/fceu-sound.c \
$(CORE_FCEUMM)/src/fceu-state.c \
$(CORE_FCEUMM)/src/fceu.c \
$(CORE_FCEUMM)/src/fds.c \
$(CORE_FCEUMM)/src/fds_apu.c \
$(CORE_FCEUMM)/src/filter.c \
$(CORE_FCEUMM)/src/general.c \
$(CORE_FCEUMM)/src/ines.c \
$(CORE_FCEUMM)/src/input.c \
$(CORE_FCEUMM)/src/md5.c \
$(CORE_FCEUMM)/src/nsf.c \
$(CORE_FCEUMM)/src/palette.c \
$(CORE_FCEUMM)/src/ppu.c \
$(CORE_FCEUMM)/src/video.c \
$(CORE_FCEUMM)/src/x6502.c
endif
endif

SMSPLUSGX_C_SOURCES = 

ifneq ($(strip $(ROMS_COL)$(ROMS_GG)$(ROMS_SG)$(ROMS_SMS)),)
SMSPLUSGX_C_SOURCES += \
retro-go-stm32/smsplusgx-go/components/smsplus/loadrom.c \
retro-go-stm32/smsplusgx-go/components/smsplus/render.c \
retro-go-stm32/smsplusgx-go/components/smsplus/sms.c \
retro-go-stm32/smsplusgx-go/components/smsplus/state.c \
retro-go-stm32/smsplusgx-go/components/smsplus/vdp.c \
retro-go-stm32/smsplusgx-go/components/smsplus/pio.c \
retro-go-stm32/smsplusgx-go/components/smsplus/tms.c \
retro-go-stm32/smsplusgx-go/components/smsplus/memz80.c \
retro-go-stm32/smsplusgx-go/components/smsplus/system.c \
retro-go-stm32/smsplusgx-go/components/smsplus/cpu/z80.c \
retro-go-stm32/smsplusgx-go/components/smsplus/sound/emu2413.c \
retro-go-stm32/smsplusgx-go/components/smsplus/sound/fmintf.c \
retro-go-stm32/smsplusgx-go/components/smsplus/sound/sn76489.c \
retro-go-stm32/smsplusgx-go/components/smsplus/sound/sms_sound.c \
retro-go-stm32/smsplusgx-go/components/smsplus/sound/ym2413.c \
Core/Src/porting/smsplusgx/main_smsplusgx.c
endif

PCE_C_SOURCES = 

ifneq ($(strip $(ROMS_PCE)),)
PCE_C_SOURCES += \
retro-go-stm32/pce-go/components/pce-go/gfx.c \
retro-go-stm32/pce-go/components/pce-go/h6280.c \
retro-go-stm32/pce-go/components/pce-go/pce.c \
Core/Src/porting/pce/sound_pce.c \
Core/Src/porting/pce/main_pce.c
endif

MSX_C_SOURCES = 

ifneq ($(strip $(ROMS_MSX)),)
CORE_MSX = external/blueMSX-go
LIBRETRO_COMM_DIR  = $(CORE_MSX)/libretro-common

MSX_C_SOURCES += \
$(CORE_MSX)/Src/Libretro/Timer.c \
$(CORE_MSX)/Src/Libretro/Emulator.c \
$(CORE_MSX)/Src/Bios/Patch.c \
$(CORE_MSX)/Src/Memory/DeviceManager.c \
$(CORE_MSX)/Src/Memory/IoPort.c \
$(CORE_MSX)/Src/Memory/MegaromCartridge.c \
$(CORE_MSX)/Src/Memory/ramNormal.c \
$(CORE_MSX)/Src/Memory/ramMapper.c \
$(CORE_MSX)/Src/Memory/ramMapperIo.c \
$(CORE_MSX)/Src/Memory/RomLoader.c \
$(CORE_MSX)/Src/Memory/romMapperASCII8.c \
$(CORE_MSX)/Src/Memory/romMapperASCII16.c \
$(CORE_MSX)/Src/Memory/romMapperASCII16nf.c \
$(CORE_MSX)/Src/Memory/romMapperBasic.c \
$(CORE_MSX)/Src/Memory/romMapperCasette.c \
$(CORE_MSX)/Src/Memory/romMapperDRAM.c \
$(CORE_MSX)/Src/Memory/romMapperF4device.c \
$(CORE_MSX)/Src/Memory/romMapperKoei.c \
$(CORE_MSX)/Src/Memory/romMapperKonami4.c \
$(CORE_MSX)/Src/Memory/romMapperKonami4nf.c \
$(CORE_MSX)/Src/Memory/romMapperKonami5.c \
$(CORE_MSX)/Src/Memory/romMapperLodeRunner.c \
$(CORE_MSX)/Src/Memory/romMapperMsxDos2.c \
$(CORE_MSX)/Src/Memory/romMapperMsxMusic.c \
$(CORE_MSX)/Src/Memory/romMapperNormal.c \
$(CORE_MSX)/Src/Memory/romMapperPlain.c \
$(CORE_MSX)/Src/Memory/romMapperRType.c \
$(CORE_MSX)/Src/Memory/romMapperStandard.c \
$(CORE_MSX)/Src/Memory/romMapperSunriseIDE.c \
$(CORE_MSX)/Src/Memory/romMapperSCCplus.c \
$(CORE_MSX)/Src/Memory/romMapperTC8566AF.c \
$(CORE_MSX)/Src/Memory/SlotManager.c \
$(CORE_MSX)/Src/VideoChips/VDP_YJK.c \
$(CORE_MSX)/Src/VideoChips/VDP_MSX.c \
$(CORE_MSX)/Src/VideoChips/V9938.c \
$(CORE_MSX)/Src/VideoChips/VideoManager.c \
$(CORE_MSX)/Src/Z80/R800.c \
$(CORE_MSX)/Src/Z80/R800SaveState.c \
$(CORE_MSX)/Src/Input/JoystickPort.c \
$(CORE_MSX)/Src/Input/MsxJoystick.c \
$(CORE_MSX)/Src/IoDevice/Disk.c \
$(CORE_MSX)/Src/IoDevice/HarddiskIDE.c \
$(CORE_MSX)/Src/IoDevice/I8255.c \
$(CORE_MSX)/Src/IoDevice/MsxPPI.c \
$(CORE_MSX)/Src/IoDevice/RTC.c \
$(CORE_MSX)/Src/IoDevice/SunriseIDE.c \
$(CORE_MSX)/Src/IoDevice/TC8566AF.c \
$(CORE_MSX)/Src/SoundChips/AudioMixer.c \
$(CORE_MSX)/Src/SoundChips/AY8910.c \
$(CORE_MSX)/Src/SoundChips/SCC.c \
$(CORE_MSX)/Src/SoundChips/MsxPsg.c \
$(CORE_MSX)/Src/SoundChips/YM2413_msx.c \
$(CORE_MSX)/Src/SoundChips/emu2413_msx.c \
$(CORE_MSX)/Src/Emulator/AppConfig.c \
$(CORE_MSX)/Src/Emulator/LaunchFile.c \
$(CORE_MSX)/Src/Emulator/Properties.c \
$(CORE_MSX)/Src/Utils/IsFileExtension.c \
$(CORE_MSX)/Src/Utils/StrcmpNoCase.c \
$(CORE_MSX)/Src/Utils/TokenExtract.c \
$(CORE_MSX)/Src/Board/Board.c \
$(CORE_MSX)/Src/Board/Machine.c \
$(CORE_MSX)/Src/Board/MSX.c \
$(CORE_MSX)/Src/Input/InputEvent.c \
Core/Src/porting/msx/main_msx.c \
Core/Src/porting/msx/save_msx.c
endif

GW_C_SOURCES = 

ifneq ($(strip $(ROMS_GW)),)
CORE_GW = external/LCD-Game-Emulator
GW_C_SOURCES += \
Core/Src/porting/lib/lz4_depack.c \
$(CORE_GW)/src/cpus/sm500op.c \
$(CORE_GW)/src/cpus/sm510op.c \
$(CORE_GW)/src/cpus/sm500core.c \
$(CORE_GW)/src/cpus/sm5acore.c \
$(CORE_GW)/src/cpus/sm510core.c \
$(CORE_GW)/src/cpus/sm511core.c \
$(CORE_GW)/src/cpus/sm510base.c \
$(CORE_GW)/src/gw_sys/gw_romloader.c \
$(CORE_GW)/src/gw_sys/gw_graphic.c \
$(CORE_GW)/src/gw_sys/gw_system.c \
Core/Src/porting/gw/main_gw.c
endif

WSV_C_SOURCES = 

ifneq ($(strip $(ROMS_WSV)),)
CORE_WSV = external/potator
WSV_C_SOURCES += \
$(CORE_WSV)/common/controls.c \
$(CORE_WSV)/common/gpu.c \
$(CORE_WSV)/common/m6502/m6502.c \
$(CORE_WSV)/common/memorymap.c \
$(CORE_WSV)/common/timer.c \
$(CORE_WSV)/common/watara.c \
$(CORE_WSV)/common/wsv_sound.c \
Core/Src/porting/wsv/main_wsv.c
endif

MD_C_SOURCES = 

ifneq ($(strip $(ROMS_MD)),)
CORE_GWENESIS = external/gwenesis
MD_C_SOURCES += \
$(CORE_GWENESIS)/src/cpus/M68K/m68kcpu.c \
$(CORE_GWENESIS)/src/cpus/Z80/Z80.c \
$(CORE_GWENESIS)/src/sound/z80inst.c \
$(CORE_GWENESIS)/src/sound/ym2612.c \
$(CORE_GWENESIS)/src/sound/gwenesis_sn76489.c \
$(CORE_GWENESIS)/src/bus/gwenesis_bus.c \
$(CORE_GWENESIS)/src/io/gwenesis_io.c \
$(CORE_GWENESIS)/src/vdp/gwenesis_vdp_mem.c \
$(CORE_GWENESIS)/src/vdp/gwenesis_vdp_gfx.c \
$(CORE_GWENESIS)/src/savestate/gwenesis_savestate.c \
Core/Src/porting/gwenesis/main_gwenesis.c
endif

A7800_C_SOURCES = 

ifneq ($(strip $(ROMS_A7800)),)
CORE_PROSYSTEM = external/prosystem-go
A7800_C_SOURCES += \
$(CORE_PROSYSTEM)/core/Bios.c \
$(CORE_PROSYSTEM)/core/Cartridge.c \
$(CORE_PROSYSTEM)/core/Database.c \
$(CORE_PROSYSTEM)/core/Hash.c \
$(CORE_PROSYSTEM)/core/Maria.c \
$(CORE_PROSYSTEM)/core/Memory.c \
$(CORE_PROSYSTEM)/core/Palette.c \
$(CORE_PROSYSTEM)/core/Pokey.c \
$(CORE_PROSYSTEM)/core/ProSystem.c \
$(CORE_PROSYSTEM)/core/Region.c \
$(CORE_PROSYSTEM)/core/Riot.c \
$(CORE_PROSYSTEM)/core/Sally.c \
$(CORE_PROSYSTEM)/core/Tia.c \
Core/Src/porting/a7800/main_a7800.c
endif

AMSTRAD_C_SOURCES = 

ifneq ($(strip $(ROMS_AMSTRAD)),)
CORE_AMSTRAD = external/caprice32-go
AMSTRAD_C_SOURCES += \
$(CORE_AMSTRAD)/cap32/cap32.c \
$(CORE_AMSTRAD)/cap32/crtc.c \
$(CORE_AMSTRAD)/cap32/fdc.c \
$(CORE_AMSTRAD)/cap32/kbdauto.c \
$(CORE_AMSTRAD)/cap32/psg.c \
$(CORE_AMSTRAD)/cap32/slots.c \
$(CORE_AMSTRAD)/cap32/cap32_z80.c \
Core/Src/porting/amstrad/main_amstrad.c \
Core/Src/porting/amstrad/amstrad_catalog.c \
Core/Src/porting/amstrad/amstrad_format.c \
Core/Src/porting/amstrad/amstrad_loader.c \
Core/Src/porting/amstrad/amstrad_video8bpp.c
endif

VIDEOPAC_C_SOURCES = 

ifneq ($(strip $(ROMS_VIDEOPAC)),)
CORE_O2EM = external/o2em-go
VIDEOPAC_C_SOURCES += \
$(CORE_O2EM)/src/o2em_audio.c \
$(CORE_O2EM)/src/o2em_cpu.c \
$(CORE_O2EM)/src/o2em_cset.c \
$(CORE_O2EM)/src/o2em_keyboard.c \
$(CORE_O2EM)/src/o2em_score.c \
$(CORE_O2EM)/src/o2em_table.c \
$(CORE_O2EM)/src/o2em_vdc.c \
$(CORE_O2EM)/src/o2em_vmachine.c \
$(CORE_O2EM)/src/o2em_voice.c \
$(CORE_O2EM)/src/o2em_vpp.c \
$(CORE_O2EM)/src/o2em_vpp_cset.c \
$(CORE_O2EM)/allegrowrapper/wrapalleg.c \
$(CORE_O2EM)/src/vkeyb/ui.c \
$(CORE_O2EM)/src/vkeyb/vkeyb.c \
$(CORE_O2EM)/src/vkeyb/vkeyb_config.c \
$(CORE_O2EM)/src/vkeyb/vkeyb_layout.c \
Core/Src/porting/videopac/main_videopac.c
endif

CELESTE_C_SOURCES = 

ifneq ($(strip $(HOMEBREW_CELESTE)),)
CORE_CCLESTE = external/ccleste-go
CELESTE_C_SOURCES += \
$(CORE_CCLESTE)/celeste.c \
$(CORE_CCLESTE)/celeste_audio.c \
Core/Src/porting/celeste/main_celeste.c
endif

TAMP_C_INCLUDES += -I$(TAMP_DIR)

ZELDA3_C_SOURCES = 

ifneq ("$(wildcard roms/zelda3/zelda3.sfc)","")
CORE_ZELDA3 = external/zelda3
ZELDA3_C_SOURCES += \
$(CORE_ZELDA3)/zelda_rtl.c \
$(CORE_ZELDA3)/misc.c \
$(CORE_ZELDA3)/nmi.c \
$(CORE_ZELDA3)/poly.c \
$(CORE_ZELDA3)/attract.c \
$(CORE_ZELDA3)/snes/ppu.c \
$(CORE_ZELDA3)/snes/dma.c \
$(CORE_ZELDA3)/spc_player.c \
$(CORE_ZELDA3)/util.c \
$(CORE_ZELDA3)/audio.c \
$(CORE_ZELDA3)/overworld.c \
$(CORE_ZELDA3)/ending.c \
$(CORE_ZELDA3)/select_file.c \
$(CORE_ZELDA3)/dungeon.c \
$(CORE_ZELDA3)/messaging.c \
$(CORE_ZELDA3)/hud.c \
$(CORE_ZELDA3)/load_gfx.c \
$(CORE_ZELDA3)/ancilla.c \
$(CORE_ZELDA3)/player.c \
$(CORE_ZELDA3)/sprite.c \
$(CORE_ZELDA3)/player_oam.c \
$(CORE_ZELDA3)/snes/dsp.c \
$(CORE_ZELDA3)/sprite_main.c \
$(CORE_ZELDA3)/tagalong.c \
$(CORE_ZELDA3)/third_party/opus-1.3.1-stripped/opus_decoder_amalgam.c \
$(CORE_ZELDA3)/tile_detect.c \
$(CORE_ZELDA3)/overlord.c \
Core/Src/porting/zelda3/main_zelda3.c \
Core/Src/porting/zelda3/zelda_assets.c
endif

SMW_C_SOURCES = 

ifneq ("$(wildcard roms/smw/smw.sfc)","")
CORE_SMW = external/smw
SMW_C_SOURCES += \
$(CORE_SMW)/src/smw_rtl.c \
$(CORE_SMW)/src/smw_00.c \
$(CORE_SMW)/src/smw_01.c \
$(CORE_SMW)/src/smw_02.c \
$(CORE_SMW)/src/smw_03.c \
$(CORE_SMW)/src/smw_04.c \
$(CORE_SMW)/src/smw_05.c \
$(CORE_SMW)/src/smw_07.c \
$(CORE_SMW)/src/smw_0c.c \
$(CORE_SMW)/src/smw_0d.c \
$(CORE_SMW)/src/smw_cpu_infra.c \
$(CORE_SMW)/src/smw_spc_player.c \
$(CORE_SMW)/src/config.c \
$(CORE_SMW)/src/common_rtl.c \
$(CORE_SMW)/src/common_cpu_infra.c \
$(CORE_SMW)/src/util.c \
$(CORE_SMW)/src/lm.c \
$(CORE_SMW)/src/snes/ppu.c \
$(CORE_SMW)/src/snes/dma.c \
$(CORE_SMW)/src/snes/dsp.c \
$(CORE_SMW)/src/snes/apu.c \
$(CORE_SMW)/src/snes/spc.c \
$(CORE_SMW)/src/snes/snes.c \
$(CORE_SMW)/src/snes/cpu.c \
$(CORE_SMW)/src/snes/cart.c \
$(CORE_SMW)/src/tracing.c \
Core/Src/porting/smw/main_smw.c \
Core/Src/porting/smw/smw_assets.c
endif

GNUBOY_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-Iretro-go-stm32/gnuboy-go/components \

TGBDUAL_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Inc/porting/gb_tgbdual \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-I$(CORE_TGBDUAL) \
-I$(CORE_TGBDUAL)/gb_core \
-I$(CORE_TGBDUAL)/libretro \
-I.

NES_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/nofrendo-go/components/nofrendo/cpu \
-Iretro-go-stm32/nofrendo-go/components/nofrendo/mappers \
-Iretro-go-stm32/nofrendo-go/components/nofrendo/nes \
-Iretro-go-stm32/nofrendo-go/components/nofrendo \
-Iretro-go-stm32/components/odroid \
-I.

NES_FCEU_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-I$(CORE_FCEUMM)/src/ \
-I.

SMSPLUSGX_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-Iretro-go-stm32/smsplusgx-go/components/smsplus \
-Iretro-go-stm32/smsplusgx-go/components/smsplus/cpu \
-Iretro-go-stm32/smsplusgx-go/components/smsplus/sound \
-I.

PCE_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-Iretro-go-stm32/pce-go/components/pce-go \
-I.

GW_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-I$(CORE_GW)/src \
-I$(CORE_GW)/src/cpus \
-I$(CORE_GW)/src/gw_sys \
-I.

MD_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-I$(CORE_GWENESIS)/src/cpus/M68K \
-I$(CORE_GWENESIS)/src/cpus/Z80 \
-I$(CORE_GWENESIS)/src/sound \
-I$(CORE_GWENESIS)/src/bus \
-I$(CORE_GWENESIS)/src/vdp \
-I$(CORE_GWENESIS)/src/io \
-I$(CORE_GWENESIS)/src/savestate \
-I.


C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-ICore/Src/porting/lib/littlefs/ \
-ICore/Src/porting/lib/tamp/tamp/_c_src \
-Iretro-go-stm32/components/odroid \
-I.

MSX_C_INCLUDES += \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-I$(CORE_MSX) \
-I$(LIBRETRO_COMM_DIR)/include \
-I$(CORE_MSX)/Src/Arch \
-I$(CORE_MSX)/Src/Bios \
-I$(CORE_MSX)/Src/Board \
-I$(CORE_MSX)/Src/BuildInfo \
-I$(CORE_MSX)/Src/Common \
-I$(CORE_MSX)/Src/Debugger \
-I$(CORE_MSX)/Src/Emulator \
-I$(CORE_MSX)/Src/IoDevice \
-I$(CORE_MSX)/Src/Language \
-I$(CORE_MSX)/Src/Media \
-I$(CORE_MSX)/Src/Memory \
-I$(CORE_MSX)/Src/Resources \
-I$(CORE_MSX)/Src/SoundChips \
-I$(CORE_MSX)/Src/TinyXML \
-I$(CORE_MSX)/Src/Utils \
-I$(CORE_MSX)/Src/VideoChips \
-I$(CORE_MSX)/Src/VideoRender \
-I$(CORE_MSX)/Src/Z80 \
-I$(CORE_MSX)/Src/Input \
-I$(CORE_MSX)/Src/Libretro \
-I.

WSV_C_INCLUDES += \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-I$(CORE_WSV)/common \
-I.

A7800_C_INCLUDES += \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-I$(CORE_PROSYSTEM)/core \
-I.

AMSTRAD_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-I$(CORE_AMSTRAD)/cap32 \
-I.

VIDEOPAC_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-I$(CORE_O2EM)/src \
-I$(CORE_O2EM)/libretro-common/include \
-I$(CORE_O2EM)/allegrowrapper \
-I.

ZELDA3_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-I$(CORE_ZELDA3) \
-Iexternal \
-I.

SMW_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-I$(CORE_SMW) \
-Iexternal \
-I.

CELESTE_C_INCLUDES +=  \
-ICore/Inc \
-ICore/Src/porting/lib \
-ICore/Src/porting/lib/lzma \
-Iretro-go-stm32/components/odroid \
-I$(CORE_CCLESTE)\
-I.


include Makefile.common


$(BUILD_DIR)/$(TARGET)_extflash.bin: $(BUILD_DIR)/$(TARGET).elf | $(BUILD_DIR)
	$(V)$(ECHO) [ BIN ] $(notdir $@)
	$(V)$(BIN) -j ._itcram_hot -j ._ram_exec -j ._extflash -j .overlay_nes -j .overlay_nes_fceu -j .overlay_gb -j .overlay_tgb -j .overlay_sms -j .overlay_col -j .overlay_pce -j .overlay_msx -j .overlay_gw -j .overlay_wsv -j .overlay_md -j .overlay_a7800 -j .overlay_amstrad -j .overlay_zelda3 -j .overlay_smw -j .overlay_videopac -j .overlay_celeste $< $(BUILD_DIR)/$(TARGET)_extflash.bin

$(BUILD_DIR)/$(TARGET)_intflash.bin: $(BUILD_DIR)/$(TARGET).elf | $(BUILD_DIR)
	$(V)$(ECHO) [ BIN ] $(notdir $@)
	$(V)$(BIN) -j .isr_vector -j .text -j .rodata -j .ARM.extab -j .preinit_array -j .init_array -j .fini_array -j .data $< $(BUILD_DIR)/$(TARGET)_intflash.bin

$(BUILD_DIR)/$(TARGET)_intflash2.bin: $(BUILD_DIR)/$(TARGET).elf | $(BUILD_DIR)
	$(V)$(ECHO) [ BIN ] $(notdir $@)
	$(V)$(BIN) -j .flash2 $< $(BUILD_DIR)/$(TARGET)_intflash2.bin
