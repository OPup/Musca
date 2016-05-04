
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 1}}
directive set /Render/core/main/for CSTEPS_FROM {{. == 2} {.. == 1}}

# IO operation constraints
directive set /Render/core/main/for/for:io_write(v_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /Render/core/main/for/for:if:acc#10 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#6 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#9 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#12 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#8 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#11 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#13 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#14 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#15 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#5 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:if:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:mux CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc CSTEPS_FROM {{.. == 1}}
