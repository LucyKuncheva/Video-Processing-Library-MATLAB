# Video-Processing-Library-MATLAB
Functions for processing video: feature extraction, summarisation, comparison of keyframe summaries, visualisation

* functions

`x = fox_get_features(im,fstr,blocks,bins)`

`[match, value] = fox_match_two_vectors(a,b,threshold,d)`

`[match, value] = fox_match_two_frames_surf(A,B,threshold,vis)`

`[F,number_of_matches,mcs,mgt] = fox_pairing_frames(matchMatrix,threshold,pairingMethod)`

`fox_montage(f,s,c,w)`

`fox_plot_grid(r,c,t,axesHandle,fontName)`

`[Matching,Cost] = assignment_hungarian(Perf)`

* scripts

`FoxsVideoToolboxTester_Features`
`FoxsVideoToolboxTester_MatchingFrames`
`FoxsVideoToolboxTester_MatchingSummaries`
`FoxsVideoToolboxTester_Pipeline`

* images

`betws_y_coed_small.jpg` image used in the scripts (testers)

A zip file `KeyframeSummaries.zip` containing a folder with two keyframe summaries used in `FoxsVideoToolboxTester_Pipeline`.


* documents

`VID_Library.pdf` is a text explaining the content and the functioning of the toolbox.

* related publications

[1] Kuncheva, L. I., P. Yousefi and J. Almeida, Edited nearest neighbour for selecting keyframe summaries of egocentric videos, Journal of Visual Communication and Image Representation 52, 2018, 118–130. 

[2] Kuncheva L. I., P. Yousefi and J. Almeida, Comparing Keyframe Summaries of Egocentric Videos: Closest-to-Centroid Baseline, Proceedings of The Seventh International Conference on Image Processing Theory, Tools and Applications (IPTA 2017), 2017, Montreal, Canada.

[3] Kuncheva L. I., P. Yousefi and I. A. D. Gunn, On the Evaluation of Video Keyframe Summaries using User Ground Truth, arXiv:1712.06899, 2017.

[4] Gunn I. A. D., L. I. Kuncheva, and P. Yousefi, Bipartite Graph Matching for Keyframe Summary Evaluation, arXiv:1712.06914, 2017.
