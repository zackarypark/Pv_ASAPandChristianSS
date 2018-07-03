# -----------------------------------
# This is an example function script for my project
# This is where I keep all of my functions for a project 
# Author: Nick Brazeau
# -----------------------------------


# -----------------------------------
# Functions for 01_vcf_filter
# -----------------------------------

# vcf to tidy dataframe
vcf_info_field_to_tidy <-  function(vcf){
  infolist <- c("AF", "DP", "QD", "MQ", "SOR")
  infolist <- lapply(infolist, 
                   function(x){vcfR::extract_info_tidy(vcf, info_fields = x)})
  infodf <- plyr::join_all(infolist, by = "Key", type = "left")

  if(typeof(infodf$AF) == "character"){
    infodf$AF <- as.numeric(infodf$AF) # odd default in extract_info -- but character to numeric is fine in R
  }
  return(infodf)
}
