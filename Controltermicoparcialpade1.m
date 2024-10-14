s=tf('s');	%define variable s
G1=(16*(-s+1.666))/((s+1.666)*(s+0.28))		% arma la transferencia G1
step(G1);