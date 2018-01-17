%% script to visualize data from makarov simulations

% make table

seps_matrix = 10*[0.5,1,2,3,4,...
 0.5,1,2,3,4,...
 0.5,1,2,3,4,...
 0.5,1,2,3,4,...
];

csf_depth_matrix = [1,1,1,1,1,...
0.5,0.5,0.5,0.5,0.5,...
0.25,0.25,0.25,0.25,0.25,...
0.1,0.1,0.1,0.1,0.1,...
];

vals_matrix = [0.4995,0.3758,0.2895,0.2292,0.1828,...
0.3401,0.2441,0.1760,0.1367,0.1021,...
0.1726,0.1167,0.0731,0.0558,0.0395,...
0.1347,0.0922,0.0484,0.0370,0.0259
];

csf_depths = unique(csf_depth_matrix);
unique_seps = unique(seps_matrix);

figure
hold on
for inds = csf_depths
plot(unique_seps,vals_matrix(csf_depth_matrix == inds),'-o','linewidth',2)

end


xlabel('Separation of electrodes in mm')
ylabel('Ratio of current traveling through CSF layer')
title('Plot of Current traveling through CSF for various CSF thicknesses')
legend('0.1 mm csf','0.25 mm csf','0.5 mm csf','1 mm csf')