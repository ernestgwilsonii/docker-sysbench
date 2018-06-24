################################################################################
# sysbench - scriptable multi-threaded benchmark tool
# REF: https://github.com/akopytov/sysbench
#####################################################
# Clone
git clone https://github.com/ernestgwilsonii/docker-sysbench.git

# Build
docker build --no-cache -t ernestgwilsonii/sysbench .

# Test
docker run --rm ernestgwilsonii/sysbench:latest --version


# Create local file for lazy use!
echo -en '#!/bin/bash\ndocker run --rm ernestgwilsonii/sysbench:latest "$@"' > /usr/local/bin/sysbench && chmod +x /usr/local/bin/sysbench
################################################################################


################################################################################
# Run #
#######
sysbench --version
sysbench --help
sysbench cpu help
sysbench memory help


###############
# CPU Testing #
###############
# How fast can a single CPU complete a math task
sysbench cpu run --cpu-max-prime=10000 --threads=1


###################
# File IO Testing #
###################
cd /tmp

# sequential write (creation) test
sysbench fileio run --file-test-mode=seqwr

# sequential rewrite test
sysbench fileio run --file-test-mode=seqrewr

sysbench fileio prepare

# sequential read test
sysbench fileio run --file-test-mode=seqrd

# random read test
sysbench fileio run --file-test-mode=rndrd

# random write test
sysbench fileio run --file-test-mode=rndwr

# random r/w test
sysbench fileio run --file-test-mode=rndrw


##################
# Memory Testing #
##################
# One thread
sysbench memory run --threads=1

# Two threads (contention)
sysbench memory run --threads=2


##################
# Thread Testing #
##################
# Establish a baseline and review over time
sysbench threads run --thread-locks=8 --thread-yields=1000


#################
# Mutex Testing #
#################
# Short test
sysbench mutex run --mutex-num=4096 --mutex-locks=50000 --mutex-loops=10000

# Longer test
sysbench mutex run --mutex-num=4096 --mutex-locks=50000 --mutex-loops=1000000


