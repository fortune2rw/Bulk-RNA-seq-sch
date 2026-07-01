#!bin/bash

sudo apt-get update
sudo apt-get install -y fastqc trimmomatic samtools unzip r-base

# Install STAR manually
wget https://github.com/alexdobin/STAR/releases/download/2.7.11b/STAR_2.7.11b.zip
unzip STAR_2.7.11b.zip
sudo mv STAR_2.7.11b/Linux_x86_64_static/STAR /usr/local/bin/

# Install SRA Toolkit
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
tar -xzf sratoolkit.current-ubuntu64.tar.gz
sudo mv sratoolkit.*-ubuntu64 /opt/sratoolkit
echo 'export PATH=$PATH:/opt/sratoolkit/bin' >> ~/.bashrc
source ~/.bashrc

# Set trimmomatic alias
echo 'alias trimmomatic="java -jar /usr/share/java/trimmomatic.jar"' >> ~/.bashrc
source ~/.bashrc

echo "Installing all tools"
echo "Verifying tools..."

fastqc --version
STAR --version
trimmomatic -version
samtools --version

echo "Installation complete"
