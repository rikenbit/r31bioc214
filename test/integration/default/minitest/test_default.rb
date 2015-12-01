require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::JUnitReporter.new(reports_dir="/tmp/result/junit")]

describe 'check R version' do
  it "check R version" do
    system('/usr/local/R/3.2.2/bin/R CMD BATCH showversion.R')
    #assert system('grep "R version 3.2.2 (2014-10-31) -- \"Pumpkin Helmet\"" showversion.Rout'), 'R version is not expected version. maybe r-base package is updated'
    assert system('grep "R version 3.2.3 beta" showversion.Rout'), 'R version is not expected version. maybe r-base package is updated'
  end
end
describe 'check Bioconductor version' do
  it "check Bioconductor version" do
    system('/usr/local/R/3.2.2/bin/R CMD BATCH showBioconductorVersion.R')
    # develop
    #assert system('grep "Bioconductor version 3.0 (BiocInstaller 1.15.3)" showBioconductorVersion.Rout'), 'Bioconductor version is not expected version. maybe Bioconductor package is updated'
    # stable
    #assert system('grep "Bioconductor version 3.0 (BiocInstaller 1.16.5)" showBioconductorVersion.Rout'), 'Bioconductor version is not expected version. maybe Bioconductor package is updated'
    assert system('grep "Bioconductor version 3.2 (BiocInstaller 1.20.1)" showBioconductorVersion.Rout'), 'Bioconductor version is not expected version. maybe Bioconductor package is updated'
  end
end
