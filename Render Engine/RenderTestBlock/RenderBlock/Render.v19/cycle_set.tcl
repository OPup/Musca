
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 4}}

# IO operation constraints
directive set /Render/core/main/if:io_read(X_pix:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/if:io_write(v_out:rsc.d)#2 CSTEPS_FROM {{.. == 2}}
directive set /Render/core/main/if:io_read(X_pix:rsc.d)#1 CSTEPS_FROM {{.. == 2}}
directive set /Render/core/main/if:io_write(v_out:rsc.d) CSTEPS_FROM {{.. == 3}}

# Real operation constraints
directive set /Render/core/main/main-1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/main-2:if:acc CSTEPS_FROM {{.. == 2}}
