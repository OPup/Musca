
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 1}}
directive set /Render/core/main/for CSTEPS_FROM {{. == 2} {.. == 1}}

# IO operation constraints
directive set /Render/core/main/for/for:if:io_write(v_out:rsc.d)#1 CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /Render/core/main/for/for:if:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc CSTEPS_FROM {{.. == 1}}
