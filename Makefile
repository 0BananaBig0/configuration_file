# ############################################################################ #
# #                           File Name: Makefile                            # #
# #                          Author: Huaxiao Liang                           # #
# #                         Mail: hxliang666@qq.com                          # #
# #                         07/14/2025-Mon-23:19:52                          # #
# ############################################################################ #

.PHONY:
define MY_MACRO
	VAR := $$(shell echo val)
	ifeq ($$(VAR), val)
		VAR :=value
	else
		VAR :=none-val
	endif
endef
$(eval $(call MY_MACRO))  # Expands and executes during parsing
test:
	echo ${VAR}
