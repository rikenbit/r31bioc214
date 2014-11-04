require 'minitest/autorun'

describe 'check R version' do
  it "check R version" do
    system('R CMD BATCH showversion.R')
    assert system('grep "R version 3.1.2 (2014-10-31) -- \"Pumpkin Helmet\"" showversion.Rout'), 'R version is not expected version. maybe r-base package is updated'
  end
end

describe 'check Bioconductor version' do
  it "check Bioconductor version" do
    system('R CMD BATCH showBioconductorVersion.R')
    # develop
    #assert system('grep "Bioconductor version 3.0 (BiocInstaller 1.15.3)" showBioconductorVersion.Rout'), 'Bioconductor version is not expected version. maybe Bioconductor package is updated'
    # stable
    assert system('grep "Bioconductor version 3.0 (BiocInstaller 1.16.0)" showBioconductorVersion.Rout'), 'Bioconductor version is not expected version. maybe Bioconductor package is updated'
  end
end
