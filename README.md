# GTApprox benchmark

These are scripts and data we used to compare GTApprox against several popular approximation libraries, as described in paper **GTApprox: surrogate modeling for industrial design** (to appear). 

<img src="figures/rrms.png" alt="RRMS error profile" width="40%"/> <img src="figures/trainTime.png" alt="Training time profile" width="40%"/>

Run `runAllTests.py` to save results for all individual tests. (Each test is run in a separate process by first restricting available virtual memory (with `ulimit`, Linux-only) and then calling the script `runSingleTest.py`.) After completion, run `plotResults.py` to collect results and plot performance profiles.
