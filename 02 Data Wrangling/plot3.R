#pull in dataframe from oracle excluding universities with zero dollar tuition and fees
df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from COLLEGESTATS where tuitionfees1314 is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_gv4353', PASS='orcl_gv4353', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


df <- df %>% mutate(pell_percent = cume_dist(AVGAMTFIRSTTIMEUGPELL))
levels <- c(0, .25, .5, .75, 1)
labels <- c("Fourth Q", "Third Q", "Second Q", "First Q")
df <- df %>% filter(AVGAMTFIRSTTIMEUGPELL != "null") %>% mutate(x = cut(pell_percent, levels, labels = labels))

df %>% group_by(x) %>% summarise(mean_fac = mean(as.numeric(STUDENTFACULTYRATIO)), n=n(), mean_tuition = mean(as.numeric(TUITIONFEES1314))) %>% ggplot(aes(x=mean_fac, y=mean_tuition, color=x)) + geom_point(size=5)