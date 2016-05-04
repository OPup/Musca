
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /Render/core/main/for:if:io_write(v_out:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for:if:io_write(v_out:rsc.d)#2 CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /Render/core/main/for:and CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-2:for:if:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-2:for:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-2:for:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-1:for:if:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-1:for:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-1:for:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for:and#3 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for:mux#4 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for:mux#5 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for:mux#7 CSTEPS_FROM {{.. == 1}}
