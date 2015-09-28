df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from COLLEGESTATS where tuitionfees1314 is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_gv4353', PASS='orcl_gv4353', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
head(df)
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  facet_grid(as.character(PUBLICPRIVATE~PUBLIC), labeller=label_both) +
  labs(title='College Stats') +
  labs(x="Tuition and Fees", y=paste("Student Faculty Ratio")) +
  layer(data=df, 
        mapping=aes(x=as.numeric(as.character(TUITIONFEES1314)), y=as.numeric(as.character(STUDENTFACULTYRATIO)), color=PUBLICPRIVATE), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )