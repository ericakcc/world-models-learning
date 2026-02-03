# Phase 3: Modern YOLO Industrial Training

## Experiment Goal

Master modern YOLO architectures (v6-v8) focusing on anchor-free detection, decoupled heads, and re-parameterization. First contact with industrial defect detection datasets.

## Covered Papers

| Paper | Key Contribution |
|-------|-----------------|
| **YOLOv6** (2022) | RepVGG/EfficientRep backbone, RepPAN neck, industrial deployment focus |
| **YOLOv7** (2022) | E-ELAN, auxiliary head training, re-parameterizable convolutions |
| **YOLOv8** (2023) | Anchor-free detection, decoupled head, C2f module, unified API |

## Implementation Steps

### Architecture Analysis
1. Study YOLOv8's decoupled head: why separate classification and regression branches
2. Implement re-parameterization concept: multi-branch training → single-branch inference
3. Analyze RepVGG block structure from YOLOv6
4. Study E-ELAN (Extended Efficient Layer Aggregation Network) from YOLOv7

### Anchor-Free Detection
1. Understand anchor-free vs anchor-based: no preset box shapes, predict center + offsets directly
2. Implement YOLOv8's TaskAlignedAssigner for positive sample assignment
3. Compare anchor-based (v5) vs anchor-free (v8) training on the same dataset

### Industrial Defect Detection (First Experiment)
1. Download NEU Surface Defect Dataset (6 classes: crazing, inclusion, patches, pitted, rolled-in scale, scratches)
2. Train YOLOv8 detection on NEU dataset
3. Experiment with different model sizes (n/s/m/l) and find speed-accuracy tradeoff
4. Apply Mosaic + CopyPaste augmentation for defect-specific training

### Model Export Pipeline
1. Export PyTorch model to ONNX format
2. Convert ONNX to TensorRT (FP16)
3. Benchmark inference speed: PyTorch vs ONNX vs TensorRT

## Key Learning Points

- **Anchor-free advantage**: Simpler architecture, no anchor tuning needed, better generalization
- **Decoupled head**: Separating classification and regression improves both tasks (classification needs semantic features, regression needs spatial features)
- **Re-parameterization**: Train with complex multi-branch topology for accuracy, merge to simple structure for speed — best of both worlds
- **Industrial data characteristics**: Small defects, class imbalance, texture-heavy backgrounds
- **Export pipeline**: The full path from research model to deployable inference

## Corning Interview Alignment

| Interview Dimension | Relevance |
|--------------------|-----------|
| **Algorithm depth** | Explain anchor-free vs anchor-based tradeoffs; why decoupled heads help |
| **Engineering deployment** | ONNX/TensorRT export pipeline directly maps to Corning's edge deployment needs |
| **Industrial experience** | First hands-on experience with real industrial defect data (NEU dataset) |
| **Small target detection** | NEU dataset includes fine scratches and small inclusions — practice for glass micro-defects |
