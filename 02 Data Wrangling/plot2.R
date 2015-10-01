#pull in dataframe from oracle excluding universities with zero dollar tuition and fees
df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from COLLEGESTATS where tuitionfees1314 is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_gv4353', PASS='orcl_gv4353', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#add a new column to the dataframe using the mutate function. graph using ggplot.
df %>% mutate(insgrant_percent = cume_dist(AVGAMTFIRSTTIMEUGSTATEGRANT)) %>% arrange(desc(insgrant_percent)) %>% mutate(grad_percent = cume_dist(GRADUATIONRATE)) %>% ggplot(aes(x = insgrant_percent, y = grad_percent)) + geom_point(aes(color=PUBLICPRIVATE)) + labs(title='TITLE') + labs(x="X AXIS", y=paste("Y AXIS"))

View(df)
