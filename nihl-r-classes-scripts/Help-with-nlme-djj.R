rm(list = ls())
library(knitr)
knitr::opts_chunk$set(echo = FALSE)

library(readxl)

library(writexl)
knitr::opts_chunk$set(echo = TRUE)
library(reshape)
library(ggplot2)
library(kableExtra)
library(matrixStats)
library(dplyr)
library(lme4)
library(nlme)
library(broom.mixed)

library(purrr)

comb2<-read_csv("nihl-r-classes-data-raw/comb2_sub.csv")

ROI_SST<-c("tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.destrieux_g.Pre.SMA.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.destrieux_g.Pre.SMA.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_vlPFC.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_vlPFC.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.destrieux_g.front.inf.front.gyrus.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.destrieux_g.front.inf.front.gyrus.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_subcort.aseg_putamen.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_subcort.aseg_putamen.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_subcort.aseg_caudate.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_subcort.aseg_caudate.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_caudalanteriorcingulate.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_caudalanteriorcingulate.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_lateraloccipital.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_lateraloccipital.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_parsorbitalis.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_parsorbitalis.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_inferiorparietal.rh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.desikan_inferiorparietal.lh","tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.destrieux_g.pariet.inf.supramar.rh", "tfmri_sst_all_correct.stop.vs.correct.go_beta_cort.destrieux_g.pariet.inf.supramar.lh")
#Attempt 1 for loop, Goal: Loop through each ROI to obtain beta, set, t- and p-values
SST_Disc_RESULTS<-matrix(nrow=20,ncol=4,NA)
row.names(SST_Disc_RESULTS)<-ROI_SST
for (p in 1:length(ROI_SST)){
  pp=ROI_SST[p]
  SST_DISC_MODEL<-lme(scale(comb2[[pp]])~scale(Z_Score)+as.factor(race.4level)+scale(age)+as.factor(sex_at_birth),random=~1|abcd_site/rel_family_id,data=comb2)
  SST_DISC_SUM<-summary(SST_DISC_MODEL)
  SST_Disc_RESULTS[p,]<-SST_DISC_SUM$coefficients[2,]
  
  
}
colnames(SST_Disc_RESULTS)<-c("beta","se","t-value","p-value")


#Attempt 2: 

output <- map_dfr(ROI_SST,
                  function(x){
                    formula_mlm = as.formula(paste0(x,"~ scale(Z_Score)+as.factor(race.4level)+scale(age)+as.factor(sex_at_birth)+(1|abcd_site/rel_family_id)"));
                    model_fit = lme(formula_mlm,data=comb2) %>%
                      tidy(.) %>%
                      dplyr::mutate(variable = x);
                    return(model_fit)
                  })

