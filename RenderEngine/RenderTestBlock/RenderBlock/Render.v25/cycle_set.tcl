
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /Render/core/main/Y_pix:io_read(Y_pix:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/if:io_read(X_pix:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/if:if:io_write(v_out:rsc.d)#1 CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /Render/core/main/if:if:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/mux CSTEPS_FROM {{.. == 1}}
