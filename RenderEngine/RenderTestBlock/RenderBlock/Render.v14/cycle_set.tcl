
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 2}}
directive set /Render/core/main/main-1:for CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /Render/core/main/main-2:for CSTEPS_FROM {{. == 2} {.. == 2}}

# IO operation constraints
directive set /Render/core/main/main-1:for/for:if:io_write(v_out:rsc.d)#2 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-2:for/for:if:io_write(v_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /Render/core/main/main-1:for/main-1:for:if:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-1:for/main-1:for:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-1:for/main-1:for:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-2:for/main-2:for:if:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-2:for/main-2:for:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-2:for/main-2:for:acc CSTEPS_FROM {{.. == 1}}
