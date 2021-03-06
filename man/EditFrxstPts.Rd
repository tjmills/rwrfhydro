% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/frxst_gage_points_add.R
\name{EditFrxstPts}
\alias{EditFrxstPts}
\title{Edit the a frxst pts layer in Fulldom}
\usage{
EditFrxstPts(fullDomFile, newCopyId, gridInds, frxstInds, keep = FALSE,
  overwrite = FALSE)
}
\arguments{
\item{fullDomFile}{Character file/path to the Fulldom file to copy.}

\item{newCopyId}{Character identifier for the new copy of the fullDomFile with specified frxst_pts.}

\item{gridInds}{Integer vector of gird indices to assign the integer values in frxstInds.}

\item{frxstInds}{Integer identifiers for gridInds.}

\item{keep}{Logical Keep existing forecast points in the frxst_pts layer. May still be replaced by frxst_pts specfied 
by gridInds and frxstInds.}

\item{overwrite}{Logical If the output path/file created from fullDomFile and newCopyId already exists, then overwrite it.}
}
\description{
Note that this function removes any existing frxst_pts by default. The keep keyword keeps existing frxst_pts
upto their replacement by ones specifed by gridINds and frxstInds.
}
\examples{
\dontrun{
# this example shows how to roughly match frxst_pts to reach gages
fullDomFile <- '~/WRF_Hydro/DOMAIN_library/Boulder_Creek_100m_1km_2sqkm_full_2015_09_03/Fulldom_hires_netcdf_file.nc'
newCopyId <- 'matchRlGages'
gages <- ncdump("~/WRF_Hydro/DOMAIN_library/Boulder_Creek_100m_1km_2sqkm_full_2015_09_03/Route_Link.threeRealGagesTEST.nc", 
                'gages', quiet=TRUE)
link <- ncdump("~/WRF_Hydro/DOMAIN_library/Boulder_Creek_100m_1km_2sqkm_full_2015_09_03/Route_Link.threeRealGagesTEST.nc", 
               'link', quiet=TRUE)
whGages <- which(gages != '               ')
gageLinks <- link[whGages]
names(gageLinks) <- gages[whGages]
linkId <- ncdump(fullDomFile, "LINKID", quiet=TRUE)
whGagesFull <- plyr::llply(gageLinks, function(gl) which(linkId == gl)[1])
EditFrxstPts(fullDomFile, newCopyId, 
             gridInds=unlist(whGagesFull),
             #frxstInds=as.integer(names(whGagesFull)),  ## fails because these cant be represented as short integers
             frxstInds=as.integer(c(500,160,200)), 
             overwrite=TRUE)
}
}
\seealso{
Other nudging: \code{\link{AddRouteLinkGage}},
  \code{\link{ChanObsToTimeSlice}},
  \code{\link{MkNudgingParams}}
}
\concept{
nudging dataMgmt
}
\keyword{IO}
\keyword{manip}
