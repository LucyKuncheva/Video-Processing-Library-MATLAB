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
