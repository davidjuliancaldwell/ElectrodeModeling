function rho = calculate_resistivity(measurement,I,distance)

GF = (1/distance(1) - 1/distance(2) - 1/distance(3) + 1/distance(4));
rho = 2*pi*measurement/(GF*100*I);

end