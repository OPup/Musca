
# Loop constraints
directive set /HSVRGB/core/main CSTEPS_FROM {{. == 4}}

# IO operation constraints
directive set /HSVRGB/core/main/r:io_read(r:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/g:io_read(g:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/b:io_read(b:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/io_write(H_OUT:rsc.d) CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/io_write(S_OUT:rsc.d) CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/io_write(V_OUT:rsc.d) CSTEPS_FROM {{.. == 3}}

# Real operation constraints
directive set /HSVRGB/core/main/if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/if:if:acc CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/mux1h CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/if#3:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/if#3:if:acc CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#5:if:acc CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/mul CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/mux1h#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/acc CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:if:div CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:and CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:and#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:and#2 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:and#3 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:equal CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:if#1:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:if#1:div CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:equal CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:if:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:if:div CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:if:acc#1 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:else#1:else:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:else:div CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:else:acc#1 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:else#1:mux CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:mux#4 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:else#1:mux#1 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:mux#5 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:else#1:mux#2 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:mux#6 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:mux1h CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:acc#2 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:if#2:acc CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/else#7:mux#14 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/and#2 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/and CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/mul#1 CSTEPS_FROM {{.. == 3}}
directive set /HSVRGB/core/main/acc#5 CSTEPS_FROM {{.. == 1}}
