include config.mk

install:
	@echo Installing jennifer executables to ${PREFIX}/bin
	@mkdir -p ${PREFIX}/bin
	@cp bin/jen ${PREFIX}/bin
	@cp bin/jen-add ${PREFIX}/bin
	@cp bin/jen-delete ${PREFIX}/bin
	@cp bin/jen-internal ${PREFIX}/bin
	@cp bin/jen-list ${PREFIX}/bin
	@cp bin/jen-new ${PREFIX}/bin
	@echo Installing awk lib files to ${AWKLIB}
	@mkdir -p ${AWKLIB}
	@cp lib/jen-build.awk ${AWKLIB}
	@cp lib/jen-list.awk ${AWKLIB}
	@cp lib/jen-validate.awk ${AWKLIB}
	@echo Installation Complete

uninstall:
	@echo Uninstalling jennifer files
	@rm ${PREFIX}/bin/jen
	@rm ${PREFIX}/bin/jen-add
	@rm ${PREFIX}/bin/jen-delete
	@rm ${PREFIX}/bin/jen-internal
	@rm ${PREFIX}/bin/jen-list
	@rm ${PREFIX}/bin/jen-new
	@rm ${AWKLIB}/jen-build.awk
	@rm ${AWKLIB}/jen-list.awk
	@rm ${AWKLIB}/jen-validate.awk
	@echo Uninstallation Complete
