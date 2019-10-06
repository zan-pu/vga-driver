# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "H_BACK_PORCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "H_DISPLAY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "H_FRONT_PORCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "H_SYNC_PULSE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "H_TOTAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "V_BACK_PORCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "V_DISPLAY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "V_FRONT_PORCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "V_SYNC_PULSE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "V_TOTAL" -parent ${Page_0}


}

proc update_PARAM_VALUE.H_BACK_PORCH { PARAM_VALUE.H_BACK_PORCH } {
	# Procedure called to update H_BACK_PORCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_BACK_PORCH { PARAM_VALUE.H_BACK_PORCH } {
	# Procedure called to validate H_BACK_PORCH
	return true
}

proc update_PARAM_VALUE.H_DISPLAY { PARAM_VALUE.H_DISPLAY } {
	# Procedure called to update H_DISPLAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_DISPLAY { PARAM_VALUE.H_DISPLAY } {
	# Procedure called to validate H_DISPLAY
	return true
}

proc update_PARAM_VALUE.H_FRONT_PORCH { PARAM_VALUE.H_FRONT_PORCH } {
	# Procedure called to update H_FRONT_PORCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_FRONT_PORCH { PARAM_VALUE.H_FRONT_PORCH } {
	# Procedure called to validate H_FRONT_PORCH
	return true
}

proc update_PARAM_VALUE.H_SYNC_PULSE { PARAM_VALUE.H_SYNC_PULSE } {
	# Procedure called to update H_SYNC_PULSE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_SYNC_PULSE { PARAM_VALUE.H_SYNC_PULSE } {
	# Procedure called to validate H_SYNC_PULSE
	return true
}

proc update_PARAM_VALUE.H_TOTAL { PARAM_VALUE.H_TOTAL } {
	# Procedure called to update H_TOTAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H_TOTAL { PARAM_VALUE.H_TOTAL } {
	# Procedure called to validate H_TOTAL
	return true
}

proc update_PARAM_VALUE.V_BACK_PORCH { PARAM_VALUE.V_BACK_PORCH } {
	# Procedure called to update V_BACK_PORCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_BACK_PORCH { PARAM_VALUE.V_BACK_PORCH } {
	# Procedure called to validate V_BACK_PORCH
	return true
}

proc update_PARAM_VALUE.V_DISPLAY { PARAM_VALUE.V_DISPLAY } {
	# Procedure called to update V_DISPLAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_DISPLAY { PARAM_VALUE.V_DISPLAY } {
	# Procedure called to validate V_DISPLAY
	return true
}

proc update_PARAM_VALUE.V_FRONT_PORCH { PARAM_VALUE.V_FRONT_PORCH } {
	# Procedure called to update V_FRONT_PORCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_FRONT_PORCH { PARAM_VALUE.V_FRONT_PORCH } {
	# Procedure called to validate V_FRONT_PORCH
	return true
}

proc update_PARAM_VALUE.V_SYNC_PULSE { PARAM_VALUE.V_SYNC_PULSE } {
	# Procedure called to update V_SYNC_PULSE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_SYNC_PULSE { PARAM_VALUE.V_SYNC_PULSE } {
	# Procedure called to validate V_SYNC_PULSE
	return true
}

proc update_PARAM_VALUE.V_TOTAL { PARAM_VALUE.V_TOTAL } {
	# Procedure called to update V_TOTAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.V_TOTAL { PARAM_VALUE.V_TOTAL } {
	# Procedure called to validate V_TOTAL
	return true
}


proc update_MODELPARAM_VALUE.H_DISPLAY { MODELPARAM_VALUE.H_DISPLAY PARAM_VALUE.H_DISPLAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_DISPLAY}] ${MODELPARAM_VALUE.H_DISPLAY}
}

proc update_MODELPARAM_VALUE.H_FRONT_PORCH { MODELPARAM_VALUE.H_FRONT_PORCH PARAM_VALUE.H_FRONT_PORCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_FRONT_PORCH}] ${MODELPARAM_VALUE.H_FRONT_PORCH}
}

proc update_MODELPARAM_VALUE.H_SYNC_PULSE { MODELPARAM_VALUE.H_SYNC_PULSE PARAM_VALUE.H_SYNC_PULSE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_SYNC_PULSE}] ${MODELPARAM_VALUE.H_SYNC_PULSE}
}

proc update_MODELPARAM_VALUE.H_BACK_PORCH { MODELPARAM_VALUE.H_BACK_PORCH PARAM_VALUE.H_BACK_PORCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_BACK_PORCH}] ${MODELPARAM_VALUE.H_BACK_PORCH}
}

proc update_MODELPARAM_VALUE.H_TOTAL { MODELPARAM_VALUE.H_TOTAL PARAM_VALUE.H_TOTAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H_TOTAL}] ${MODELPARAM_VALUE.H_TOTAL}
}

proc update_MODELPARAM_VALUE.V_DISPLAY { MODELPARAM_VALUE.V_DISPLAY PARAM_VALUE.V_DISPLAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_DISPLAY}] ${MODELPARAM_VALUE.V_DISPLAY}
}

proc update_MODELPARAM_VALUE.V_FRONT_PORCH { MODELPARAM_VALUE.V_FRONT_PORCH PARAM_VALUE.V_FRONT_PORCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_FRONT_PORCH}] ${MODELPARAM_VALUE.V_FRONT_PORCH}
}

proc update_MODELPARAM_VALUE.V_SYNC_PULSE { MODELPARAM_VALUE.V_SYNC_PULSE PARAM_VALUE.V_SYNC_PULSE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_SYNC_PULSE}] ${MODELPARAM_VALUE.V_SYNC_PULSE}
}

proc update_MODELPARAM_VALUE.V_BACK_PORCH { MODELPARAM_VALUE.V_BACK_PORCH PARAM_VALUE.V_BACK_PORCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_BACK_PORCH}] ${MODELPARAM_VALUE.V_BACK_PORCH}
}

proc update_MODELPARAM_VALUE.V_TOTAL { MODELPARAM_VALUE.V_TOTAL PARAM_VALUE.V_TOTAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.V_TOTAL}] ${MODELPARAM_VALUE.V_TOTAL}
}

