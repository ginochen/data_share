function plot_camdecomp(iic,dosave)
season = 'JJA';
dlat = 'lat9090';
casei = 'F_2000_SPCAM_m2005_3hrly2';
xpts = 30;
dpts = [num2str(xpts) 'pts'];
dims = '2d';
diro = ['/Users/g/draft/convection_stochastic/agu-revision1/fig/' season '/mcsmap/tave/'] % output
load mcs_clusters_1.mat 
load mcs_cluster_parm.mat
eval(sprintf(['load mcs_cluster_xy_var_' sprintf('%02d',iic) '.mat']));
icent = xpts/2;
ic=idxc(iic);
scl = 86400;

% plot vertical profile of CAMDT (zmdt+evaptzm+cmfdt+(mpdt+macpdt)*(1/1004)) at the centroid lat lon
it = 1;
z1d = squeeze(vo.z1d{ic}{it}(icent,icent,:));
zi = parm.zint/1000;
plot(squeeze(vo.camdti{ic}{it}(icent,icent,:))',zi,'k','linewidth',5,'markersize',15); hold on
plot(squeeze(vo.mpdt{ic}{it}(icent,icent,:))'*scl,zi,'r','linewidth',3,'markersize',15)
plot(squeeze(vo.zmdt{ic}{it}(icent,icent,:))'*scl,zi,'k-.','linewidth',1,'markersize',15)
plot(squeeze(vo.evaptzm{ic}{it}(icent,icent,:))'*scl,zi,'k-x','linewidth',1,'markersize',15)
plot(squeeze(vo.cmfdt{ic}{it}(icent,icent,:))'*scl,zi,'ko-','linewidth',1,'markersize',15)
plot(squeeze(vo.macpdt{ic}{it}(icent,icent,:))'*scl,zi,'k*-','linewidth',1,'markersize',15)
set(gca,'fontsize',44)
h = legend('Q1_{CAM}','P_{micro}','P_{deep}','P_{evap}','P_{shallow}','P_{macro}');
set(h,'fontsize',35)
ylim([0 zi(end)])
ylabel('[km]')
xlabel('[K day^{-1}]')
if dosave
  saveas(gca,[diro '/camdecomp_c' num2str(iic) '.png']);
  crop([diro '/camdecomp_c' num2str(iic) '.png']);
end
