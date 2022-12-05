PROJECT_NAME = picosoc
PREFIX ?= /snap/nextpnr-kintex/current
DB_DIR=${PREFIX}/opt/nextpnr-xilinx/external/prjxray-db
CHIPDB=../chipdb

ifeq (${BOARD}, qmtech)
PART = xc7k325tffg676-1
FREQ = --freq 50
else ifeq (${BOARD}, genesys2)
PART = xc7k325tffg900-2
else ifeq (${BOARD}, kx2)
PART = xc7k160tffg676-2
else ifeq (${BOARD}, hpc_420t)
PART = xc7k420tffg901-1
else
.PHONY: check
check:
	@echo "BOARD environment variable not set. Available boards:"
	@echo " * qmtech"
	@echo " * genesys2"
	@echo " * kx2"
	@echo " * hpc_420t"
	@exit 1
endif

.PHONY: all
all: ${PROJECT_NAME}.bit

${PROJECT_NAME}.json: ${BOARD}.v picosoc_noflash.v picorv32.v progmem.v simpleuart.v
	yosys -p "synth_xilinx -flatten -abc9 -arch xc7 -top top; write_json ${PROJECT_NAME}.json" $^

# The chip database only needs to be generated once
# that is why we don't clean it with make clean
${CHIPDB}/${PART}.bin:
	python3 ${PREFIX}/opt/nextpnr-xilinx/python/bbaexport.py --device ${PART} --bba ${PART}.bba
	bbasm -l ${PART}.bba ${CHIPDB}/${PART}.bin
	rm -f ${PART}.bba

${PROJECT_NAME}.fasm: ${PROJECT_NAME}.json
	nextpnr-xilinx ${FREQ} --chipdb ${CHIPDB}/${PART}.bin --xdc ${PROJECT_NAME}-${BOARD}.xdc --json $< --write ${PROJECT_NAME}_routed.json --fasm $@

${PROJECT_NAME}.frames: ${PROJECT_NAME}.fasm
	#@. "${XRAY_DIR}/utils/environment.sh"
	fasm2frames --part ${PART} --db-root ${DB_DIR}/kintex7 $< > $@

${PROJECT_NAME}.bit: ${PROJECT_NAME}.frames
	#@. "${XRAY_DIR}/utils/environment.sh"
	xc7frames2bit --part_file ${DB_DIR}/kintex7/${PART}/part.yaml --part_name ${PART} --frm_file $< --output_file $@

.PHONY: clean
clean:
	@rm -f *.bit
	@rm -f *.frames
	@rm -f *.fasm
	@rm -f *.json
