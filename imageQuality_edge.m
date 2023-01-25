function [WEW]=imageQuality_edge(img,filter)
img= rescale(img, 0, 255);
edge= auto_edge_detection(img, filter);
WEW= imageQuality_edge4(edge);
end