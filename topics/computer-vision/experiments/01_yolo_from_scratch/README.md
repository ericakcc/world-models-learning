# Phase 1: YOLO From Scratch

## Experiment Goal

Build YOLOv1 and YOLOv2 core components from scratch in PyTorch to deeply understand single-stage object detection fundamentals.

## Covered Papers

| Paper | Key Contribution |
|-------|-----------------|
| **YOLOv1** (2016) | Grid-based single-stage detection, unified architecture |
| **YOLOv2** (2017) | Anchor boxes, batch normalization, multi-scale training, Darknet-19 |

## Implementation Steps

### YOLOv1
1. Implement the grid-based detection head (S x S grid, B bounding boxes per cell, C classes)
2. Build the YOLOv1 loss function (localization + confidence + classification)
3. Implement IoU calculation and non-maximum suppression (NMS)
4. Train on Pascal VOC 2007 subset
5. Visualize detection results

### YOLOv2 Improvements
1. Add batch normalization to all convolutional layers
2. Implement anchor boxes with k-means clustering on training data
3. Add passthrough layer (fine-grained features)
4. Implement multi-scale training (random input resolution)
5. Compare v1 vs v2 performance on the same dataset

## Key Learning Points

- **Why single-stage is fast**: One forward pass vs two-stage proposal + classification
- **Grid-based prediction**: How dividing the image into cells enables parallel detection
- **Anchor boxes**: Why prior shapes improve recall (v2's key innovation over v1)
- **Loss function design**: Balancing localization, confidence, and classification losses
- **Multi-scale training**: Why random resolution improves robustness

## Corning Interview Alignment

| Interview Dimension | Relevance |
|--------------------|-----------|
| **Algorithm depth** | Explain the fundamental YOLO detection paradigm from first principles |
| **Engineering** | Demonstrate ability to implement core algorithms, not just call APIs |
| **Small target detection** | Understand why v1 struggles with small objects (grid resolution limit) and how v2's anchor boxes begin to address this |
