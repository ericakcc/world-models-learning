# **交互式世界模型與生成式神經模擬器：從 Google Genie 3 到高效能單機研究實踐報告**

隨著人工智慧從單純的靜態內容生成邁向對物理現實的動態理解，世界模型（World Models）已成為實現通用人工智慧（AGI）的核心路徑之一。Google 最近發佈的 Genie 3 展示了如何透過大規模數據預訓練，構建出具備即時互動性、空間一致性與因果推理能力的虛擬環境 1。對於擁有 NVIDIA GeForce RTX 5090 等頂級硬體的研究者而言，當前的技術環境提供了前所未有的機會，使其能夠在本地端重現並擴展頂尖實驗室的研究成果。本報告將深入探討世界模型的理論架構、Genie 系列的技術演進、針對 RTX 5090 的硬體優化策略，以及如何利用開源資料集快速實作具備展示價值的研究專案。

## **世界模型的基礎理論與研究範式**

世界模型的核心定義是一個能夠在內部模擬外部世界演變的計算系統，通常具備預測代理人（Agent）在特定行動後環境狀態變化的能力 3。這種模型不僅僅是視頻生成器，更是一個具備「物理直覺」的模擬器，理解如重力、物體遮擋與因果關係等基本規則 4。

### **世界模型的 VMC 核心架構**

經典的世界模型架構（由 Ha 與 Schmidhuber 提出）將代理人分為三個關鍵組件：視覺模型（Vision, V）、記憶模型（Memory, M）與控制器（Controller, C） 6。視覺模型通常採用卷積變分自編碼器（VAE），將高維的原始像素輸入壓縮為低維的隱含向量 ![][image1]；記憶模型（如 MDN-RNN）則負責預測隱含向量隨時間的演化；最後由控制器根據當前的隱含狀態決定行動 6。

在 2026 年的技術背景下，這一架構已演進為基於 Transformer 或擴散模型（Diffusion Models）的高級形式，例如 DreamerV3 或 GameNGen 7。這些模型不再僅限於簡單的 2D 網格，而是能夠在潛在空間（Latent Space）中進行長程規劃（Long-horizon Planning）與反事實分析（Counterfactual Analysis），即詢問「如果我採取行動 A 而非 B，世界會變成什麼樣？」 3。

### **交互式世界模型的五大競爭路徑**

目前學術界與工業界在構建空間世界模型（Spatial World Models）時，主要採取以下五種路徑，其各自的技術特徵與資源消耗如下表所示：

| 技術路徑 | 代表模型 | 核心機制 | 優勢 | 資源需求 |
| :---- | :---- | :---- | :---- | :---- |
| **自回歸 Transformer** | Genie 3, Oasis | 逐幀預測隱含標記 (Tokens) | 即時反應速度極快 4 | 高 VRAM 頻寬需求 11 |
| **潛在擴散模型 (LDM)** | GameNGen, DIAMOND | 迭代去噪生成潛在狀態 | 視覺細節極其豐富 7 | 高算力 (TFLOPS) 需求 13 |
| **聯合嵌入預測架構 (JEPA)** | V-JEPA, Drive-JEPA | 預測抽象嵌入而非像素 | 學習效率與魯棒性高 9 | 中等，專注於語義學習 3 |
| **主動推理 (Active Inference)** | AXIOM | 最小化變分自由能 | 具備原則性的不確定性處理 10 | 低至中等，適合決策邏輯 10 |
| **神經放射場 (NeRF/Gaussian)** | NuRec, World Labs | 3D 體素或高斯點雲重建 | 空間一致性與視角切換完美 15 | 極高，需大量多視角數據 15 |

## **Google Genie 系列的演進與 Genie 3 的技術突破**

Google DeepMind 開發的 Genie（Generative Interactive Environments）系列體現了從基礎物理模擬到高保真虛擬世界生成的跨越。Genie 3 的發佈，標誌著世界模型從研究原型轉向具備初步可用性的互動平台 14。

### **從 Genie 1 到 Genie 3 的技術路徑**

Genie 系列的演進並非單純的參數增加，而是架構與訓練數據多模態性的本質提升 19。

| 特性 | Genie 1 (2024.03) | Genie 2 (2024.12) | Genie 3 (2025.08) |
| :---- | :---- | :---- | :---- |
| **核心架構** | 簡單生成框架 19 | 混合強化學習架構 19 | 高級生成式 Transformer 19 |
| **解析度** | 低保真度 (2D/網格) 19 | 中等保真度 (360p) 4 | 高保真度 (720p) 2 |
| **即時性** | 無/受限 4 | 部分動作受限 4 | 即時互動 (24 FPS) 2 |
| **一致性** | 極短暫 | 約 10-20 秒 4 | 超過 1 分鐘 4 |
| **多模態支持** | 僅文本/結構化輸入 19 | 文本 \+ 視覺初步融合 19 | 全方位：文本、圖像、視頻、動作 19 |

Genie 3 的關鍵進步在於其採用的自回歸流水線（Autoregressive Pipeline），該系統在每一幀都會重新讀取整個動作軌跡，這使得模型能夠在用戶於場景中「往回走」時，依然保持環境的空間一致性，例如原本在身後的樹木或建築不會因為消失在視圖中而被模型遺忘 4。

### **Genie 3 的創新功能：可提示的世界事件 (Promptable World Events)**

Genie 3 引入了「可提示的世界事件」功能，允許用戶在探索過程中透過文本指令實時改變環境屬性 4。例如，在探索一個沙漠場景時輸入「開始下雨」，模型能動態地將雨水物理效果、濕滑的地面紋理以及光影變化集成到當前的生成循環中 4。這對於訓練需要適應突發狀況的 AI 代理人（Agents）具有極高的價值，因為它提供了一個無限且可控的邊角案例（Corner Cases）生成器 2。

然而，Genie 3 目前仍存在顯著局限，包括每節 60 秒的時間限制、約 720p 的解析度以及明顯的操作延遲（Input Lag），這反映了大規模神經渲染對算力的極端消耗 1。

## **硬體實戰：利用 NVIDIA RTX 5090 進行世界模型研究**

NVIDIA GeForce RTX 5090 的 Blackwell 架構為本地端的世界模型研究提供了核心支援 11。對於研究者而言，32GB 的 GDDR7 顯存是解決模型上下文長度與生成解析度瓶頸的關鍵。

### **RTX 5090 核心技術優勢分析**

下表對比了 RTX 5090 與前代旗艦 4090 在 AI 研究中的關鍵指標：

| 規格項目 | RTX 4090 (Ada) | RTX 5090 (Blackwell) | 對研究的意義 |
| :---- | :---- | :---- | :---- |
| **顯存容量 (VRAM)** | 24 GB GDDR6X | 32 GB GDDR7 23 | 支持更大的 Batch Size 或更長的序列長度 24 |
| **顯存頻寬** | 1,008 GB/s | 1,792 GB/s 25 | 顯著提升自回歸模型（如 Genie 3 類架構）的 Token 生成速度 25 |
| **Tensor Cores** | 第四代 | 第五代 22 | 引入硬體級 FP4 支持，模型吞吐量可提升 2-4 倍 22 |
| **L2 快取** | 73 MB | 98 MB 27 | 減少數據存取延遲，優化卷積與注意力運算效率 27 |
| **PCIe 標準** | Gen 4 | Gen 5 22 | 提升與系統內存交換數據的速度，對於大規模數據集加載至關重要 27 |

### **本地端優化與量化策略**

儘管 RTX 5090 性能強勁，但全參數微調（Full Fine-tuning）超過 10B 的世界模型仍顯吃力。研究者應優先採用以下技術：

1. **FP8 與 FP4 訓練：** Blackwell 架構對 FP8 的原生支持可將 LLM/WM 訓練速度提升約 1.3 倍至 1.5 倍，且透過塊級縮放（Block-level Scaling）技術，模型收斂效果能與 BF16 保持一致 28。  
2. **Unsloth 框架：** 該框架針對單一 GPU 進行了核心層級的優化，可減少高達 70% 的顯存佔用，使研究者能夠在 32GB 的 5090 上微調高達 40B 參數的模型 30。  
3. **梯度檢查點（Gradient Checkpointing）：** 這是一種以計算時間換取顯存空間的策略，對於訓練長視頻序列的世界模型尤為重要 24。  
4. **混合精度與自適應優化器：** 使用如 Adafactor 搭配 bfloat16 精度，可以有效降低內存開銷並提升訓練穩定性 24。

## **核心論文與學習資源導讀**

要深入學習世界模型，建議從以下具備代表性的論文路徑開始，這些研究均提供了可重現的開源代碼。

### **基礎與系統架構類**

* **DreamerV3 (Hafner et al., Nature 2025):** 這是目前最通用的世界模型算法之一，其特點是使用固定的超參數在包括 Minecraft 在內的數十個環境中達到領先水平 8。這篇論文是學習如何將「想像」（Imagination）轉化為「行動策略」的必讀作。  
* **Mastering Diverse Domains through World Models (Hafner et al., 2024/2025):** 詳細描述了世界模型如何透過分類隱含表示（Categorical Latents）來處理不確定性 8。

### **交互式神經引擎類**

* **GameNGen (Valevski et al., Google Research 2024):** 展示了如何使用擴散模型完全取代傳統遊戲引擎來運行《毀滅戰士》（DOOM） 7。其採用的條件增強（Conditioning Augmentations）技術是解決生成漂移的關鍵。  
* **DIAMOND (Alonso et al., NeurIPS 2024):** 這是另一個基於擴散模型的世界模型，特別強調了視覺細節對於強化學習代理人的重要性，並提供了在 Atari 遊戲上重現的完整代碼 12。

### **自動駕駛與具身智慧類**

* **GAIA-1/GAIA-2 (Wayve, 2023/2025):** 專為自動駕駛設計的世界模型，展示了如何結合視頻、文本與車輛動作來生成具備物理一致性的駕駛場景 20。  
* **MILE (Wayve, 2022):** 較早期的基於模型之模仿學習研究，適合在顯存受限的環境下進行初步實踐 3。  
* **V-JEPA (LeCun et al., Meta AI):** 介紹了非生成式的預測模型，如何透過預測視頻中的缺失部分來學習物理規律 9。

## **手作小專案與資料集實踐指南**

為了快速獲得可展示的研究成果，以下推薦三個由易到難的實作專案，並對應 RTX 5090 的硬體能力。

### **專案一：基於 JAX 的經典世界模型重現 (CarRacing-v3)**

這是一個極佳的入門專案，可以在幾小時內完成訓練並可視化結果。

* **目標：** 訓練一個代理人，在它自己的「夢境」中學習開車。  
* **代碼庫：** world-models-jax (基於 Equinox) 6。  
* **數據集：** 透過隨機或啟發式驅動程式在 Gymnasium 環境中收集 2,000-5,000 個片段 6。  
* **硬體利用：** 利用 JAX 的 jax.vmap 功能，可以在 5090 上同時並行模擬 256 個代理人的「夢境」訓練，將進化策略（Evolution Strategy）的訓練效率提升數十倍 6。  
* **核心技巧：** 使用非對稱損失函數（Asymmetric Loss）來懲罰代理人的「樂觀偏差」，確保其在模擬環境中學到的技能能遷移到真實物理環境 6。

### **專案二：擴散模型驅動的神經遊戲引擎 (Atari 100k)**

探索如何使用擴散模型構建互動式環境。

* **目標：** 在單一 5090 上訓練一個能夠即時生成 Atari 遊戲畫面的擴散模型。  
* **代碼庫：** diamond (eloialonso/diamond) 12。  
* **數據集：** Atari 100k 基準測試，包含 26 款遊戲，僅需 2 小時的人類遊戲數據即可開始 33。  
* **預期成果：** 生成一個可以由人類實時操作的「神經版」遊戲，並與傳統強化學習代理人進行對比 33。  
* **5090 優勢：** 5090 的高顯存頻寬可以大幅縮短擴散模型的反向去噪時間，實現接近 20 FPS 的互動速度 7。

### **專案三：大規模駕駛世界模型預訓練 (OpenDV-YouTube)**

這是一個具備高度展示價值的專案，適合用於學術發表或技術作品集。

* **目標：** 構建一個能夠根據導航指令生成未來駕駛視頻的世界模型。  
* **數據集：** **OpenDV-YouTube**。這是目前世界上最大的駕駛視頻數據集，包含 1,700 小時的真實駕駛視頻 39。  
  * **完整版：** 3TB 原始視頻，處理後圖像達 24TB 39。  
  * **Mini Subset (推薦)：** 25 小時視頻，原始文件約 44GB，處理後約 390GB，非常適合單機研究 39。  
* **實作路徑：**  
  1. 下載 OpenDV-mini 並進行圖像預處理 39。  
  2. 訓練一個離散或連續的視覺標記器（Tokenizer/VAE） 34。  
  3. 利用 5090 的顯存優勢，訓練一個自回歸 Transformer 來預測未來隱含狀態 4。  
* **成果展現：** 輸入「左轉」或「前方有行人」，展示模型生成的具備因果關係的未來場景。

## **全球開源資料集匯總與管理**

針對不同領域的世界模型研究，以下是 2026 年最受關注的開源資料集：

| 資料集名稱 | 領域 | 規模 | 特徵 | 獲取途徑 |
| :---- | :---- | :---- | :---- | :---- |
| **OpenDV-YouTube** | 自動駕駛 | 1,700+ 小時 39 | 包含語言標註、動作命令 40 | OpenDriveLab 39 |
| **nuScenes** | 自動駕駛 | 1,000 個場景 | 多傳感器融合、雷達、LiDAR 3 | nuScenes.org |
| **YouTube-8M** | 通用視頻 | 數百萬視頻 ID 41 | 多樣化的視覺實體與機器標註 41 | Google Research |
| **AODRaw** | 惡劣環境感知 | 7,785 張 RAW 圖像 | 覆蓋低光、雨、霧等極端天氣 42 | GitHub 42 |
| **XLRS-Bench** | 遙感/城市規劃 | 1,400 張超高解析度圖 | 像素達 10,000x10,000，適合時空變化檢測 42 | CVAT.ai 42 |
| **Physical AI Dataset** | 機器人/工業 | 多樣化的物理互動 | 專為 NVIDIA Cosmos 與 Isaac Sim 優化 16 | NVIDIA Developer |

## **實作建議與環境配置流程**

要在 RTX 5090 上順利運行上述專案，建議遵循以下系統配置流程，以確保硬體性能得到完全釋放。

### **系統環境建置 (以 Ubuntu 22.04 為例)**

1. **驅動程式與內核模組：** RTX 5090 需要使用 NVIDIA 開源內核模組（Open Kernel Modules）以獲得最佳穩定性。建議安裝 nvidia-driver-580-open 或更高版本 43。  
   Bash  
   sudo apt update  
   sudo apt install nvidia-driver-580-open  
   sudo reboot

2. **深度學習框架與 CUDA：** 確保 CUDA 版本在 12.8 以上，以支持 Blackwell 架構的 FP4/FP8 特性 24。  
   Bash  
   \# 檢查顯卡是否被識別  
   nvidia-smi

3. **環境管理工具：** 推薦使用 uv 或 conda。uv 在處理現代 Python 依賴（如 JAX 和 PyTorch 2.8+）時速度更快且更穩定 6。  
   Bash  
   \# 安裝 uv 並同步環境  
   curl \-LsSf https://astral.sh/uv/install.sh | sh  
   uv sync

### **單機多模型協作 (Vibe Coding)**

利用 32GB 顯存的優勢，研究者可以在本地同時運行一個世界模型與一個輕量化的語言模型（如 Qwen3-32B 或 Mistral-NeMo-12B），將語言模型作為世界模型的「大腦」來生成複雜指令或進行因果邏輯推理 45。透過 LoRA 微調，可以在 5090 上實現每小時處理高達 200 萬個 Token 的效率 24。

## **結論：邁向具身智慧的研究藍圖**

Google Genie 3 的釋出不僅僅是一個產品展示，它定義了「生成式模擬器」在未來 AI 生態中的地位。對於擁有高性能硬體的個人研究者，世界模型不再是遙不可及的黑盒。透過選擇如 CarRacing 或 Atari 等小規模起點進行理論驗證，隨後轉向 OpenDV 等大規模真實數據集進行能力擴展，研究者可以系統性地掌握空間智能（Spatial Intelligence）的核心 10。

未來的研究焦點將集中在如何進一步延長世界模型的一致性（Consistency）、如何降低神經渲染的延遲，以及如何實現真正的「多代理人社會物理模擬」 14。藉助 RTX 5090 提供的 FP4/FP8 算力紅利與超高顯存頻寬，本地端的研究成果將越來越接近工業界的一線水平，為通往具備實體感知與交互能力的 AGI 奠定堅實基礎。

#### **引用的著作**

1. Google Brings Genie 3 'World Building' Experiment to AI Ultra Subscribers \- CNET, 檢索日期：2月 1, 2026， [https://www.cnet.com/tech/services-and-software/google-brings-genie-3-world-building-experiment-to-ai-ultra-subscribers/](https://www.cnet.com/tech/services-and-software/google-brings-genie-3-world-building-experiment-to-ai-ultra-subscribers/)  
2. Genie 3 — Google DeepMind, 檢索日期：2月 1, 2026， [https://deepmind.google/models/genie/](https://deepmind.google/models/genie/)  
3. Awesome World Models for Autonomous Driving \- GitHub, 檢索日期：2月 1, 2026， [https://github.com/LMD0311/Awesome-World-Model](https://github.com/LMD0311/Awesome-World-Model)  
4. Genie 3: My Deep Dive into Google's Real-Time AI World Builder, 檢索日期：2月 1, 2026， [https://skywork.ai/skypage/en/Genie-3-My-Deep-Dive-into-Google%E2%80%99s-Real-Time-AI-World-Builder/1975582077712658432](https://skywork.ai/skypage/en/Genie-3-My-Deep-Dive-into-Google%E2%80%99s-Real-Time-AI-World-Builder/1975582077712658432)  
5. Genie 3: New world model by Google | Codecademy, 檢索日期：2月 1, 2026， [https://www.codecademy.com/article/googles-genie-3-world-model](https://www.codecademy.com/article/googles-genie-3-world-model)  
6. Sha01in/world-models-jax: World Models (Ha ... \- GitHub, 檢索日期：2月 1, 2026， [https://github.com/Sha01in/world-models-jax](https://github.com/Sha01in/world-models-jax)  
7. GameNGen, 檢索日期：2月 1, 2026， [https://gamengen.github.io/](https://gamengen.github.io/)  
8. danijar/dreamerv3: Mastering Diverse Domains through World Models \- GitHub, 檢索日期：2月 1, 2026， [https://github.com/danijar/dreamerv3](https://github.com/danijar/dreamerv3)  
9. World Models Reading List: The Papers You Actually Need in 2025 | by Graison Thomas, 檢索日期：2月 1, 2026， [https://medium.com/@graison/world-models-reading-list-the-papers-you-actually-need-in-2025-882f02d758a9](https://medium.com/@graison/world-models-reading-list-the-papers-you-actually-need-in-2025-882f02d758a9)  
10. World Models: Five Competing Approaches – Overview \- Themesis, Inc., 檢索日期：2月 1, 2026， [https://themesis.com/2026/01/07/world-models-five-competing-approaches/](https://themesis.com/2026/01/07/world-models-five-competing-approaches/)  
11. NVIDIA RTX 5090 & Datacenter Choices: Do They Fit AI Cloud? (2026) \- Fluence Network, 檢索日期：2月 1, 2026， [https://www.fluence.network/blog/nvidia-rtx-5090/](https://www.fluence.network/blog/nvidia-rtx-5090/)  
12. Diamond \- diffusion for world modeling, 檢索日期：2月 1, 2026， [https://diamond-wm.github.io/](https://diamond-wm.github.io/)  
13. RTX 4090 vs 5090: How Much Faster Are AI Workloads? | by Alperen | Medium, 檢索日期：2月 1, 2026， [https://medium.com/@alperenkaban/rtx-4090-vs-5090-how-much-faster-are-ai-workloads-2f972e89d870](https://medium.com/@alperenkaban/rtx-4090-vs-5090-how-much-faster-are-ai-workloads-2f972e89d870)  
14. Google's Genie 3: Real-time AI world model creates interactive 3D environments, 檢索日期：2月 1, 2026， [https://www.rdworldonline.com/googles-genie-3-breaks-through-the-real-time-barrier-for-ai-world-models/](https://www.rdworldonline.com/googles-genie-3-breaks-through-the-real-time-barrier-for-ai-world-models/)  
15. DeepMind Genie3 architecture speculation : r/MachineLearning \- Reddit, 檢索日期：2月 1, 2026， [https://www.reddit.com/r/MachineLearning/comments/1mic820/deepmind\_genie3\_architecture\_speculation/](https://www.reddit.com/r/MachineLearning/comments/1mic820/deepmind_genie3_architecture_speculation/)  
16. Accelerating AV Simulation with Neural Reconstruction and World Foundation Models, 檢索日期：2月 1, 2026， [https://developer.nvidia.com/blog/accelerating-av-simulation-with-neural-reconstruction-and-world-foundation-models/](https://developer.nvidia.com/blog/accelerating-av-simulation-with-neural-reconstruction-and-world-foundation-models/)  
17. How to Instantly Render Real-World Scenes in Interactive Simulation \- NVIDIA Developer, 檢索日期：2月 1, 2026， [https://developer.nvidia.com/blog/how-to-instantly-render-real-world-scenes-in-interactive-simulation/](https://developer.nvidia.com/blog/how-to-instantly-render-real-world-scenes-in-interactive-simulation/)  
18. Google’s Project Genie allows users to explore AI-generated worlds in real time, 檢索日期：2月 1, 2026， [https://indianexpress.com/article/technology/tech-news-technology/googles-project-genie-allows-users-to-explore-ai-generated-worlds-in-real-time-10504000/](https://indianexpress.com/article/technology/tech-news-technology/googles-project-genie-allows-users-to-explore-ai-generated-worlds-in-real-time-10504000/)  
19. Evolution of AI World Modeling: Genie 1 to Genie 3 \- Times Of AI, 檢索日期：2月 1, 2026， [https://www.timesofai.com/industry-insights/evolution-from-genie-1-to-genie-3/](https://www.timesofai.com/industry-insights/evolution-from-genie-1-to-genie-3/)  
20. Generative AI for video generation and simulation \- Wayve GAIA, 檢索日期：2月 1, 2026， [https://wayve.ai/science/gaia/](https://wayve.ai/science/gaia/)  
21. Genie 3 just dropped (for Ultra subscribers). I tested it, and here are my thoughts. : r/GeminiAI \- Reddit, 檢索日期：2月 1, 2026， [https://www.reddit.com/r/GeminiAI/comments/1qqkd5y/genie\_3\_just\_dropped\_for\_ultra\_subscribers\_i/](https://www.reddit.com/r/GeminiAI/comments/1qqkd5y/genie_3_just_dropped_for_ultra_subscribers_i/)  
22. GeForce RTX 5090 Graphics Cards \- NVIDIA, 檢索日期：2月 1, 2026， [https://www.nvidia.com/en-us/geforce/graphics-cards/50-series/rtx-5090/](https://www.nvidia.com/en-us/geforce/graphics-cards/50-series/rtx-5090/)  
23. NVIDIA GeForce RTX 5090 Specs | TechPowerUp GPU Database, 檢索日期：2月 1, 2026， [https://www.techpowerup.com/gpu-specs/geforce-rtx-5090.c4216](https://www.techpowerup.com/gpu-specs/geforce-rtx-5090.c4216)  
24. \# Harnessing the Power of NVIDIA RTX 5090 for LLM Training | Glasp, 檢索日期：2月 1, 2026， [https://glasp.co/hatch/QVcM0zahewZqDF2JM8AT2MrzWUZ2/p/Gy32lwGHEE7d06CCjL1d](https://glasp.co/hatch/QVcM0zahewZqDF2JM8AT2MrzWUZ2/p/Gy32lwGHEE7d06CCjL1d)  
25. NVIDIA GeForce RTX 5090 & 5080 AI Review \- Puget Systems, 檢索日期：2月 1, 2026， [https://www.pugetsystems.com/labs/articles/nvidia-geforce-rtx-5090-amp-5080-ai-review/](https://www.pugetsystems.com/labs/articles/nvidia-geforce-rtx-5090-amp-5080-ai-review/)  
26. Fully functional native FP4 training finally released : r/LocalLLaMA \- Reddit, 檢索日期：2月 1, 2026， [https://www.reddit.com/r/LocalLLaMA/comments/1o5n4fu/fully\_functional\_native\_fp4\_training\_finally/](https://www.reddit.com/r/LocalLLaMA/comments/1o5n4fu/fully_functional_native_fp4_training_finally/)  
27. NVIDIA GeForce RTX 5090 Specs: Everything You Need to Know \- Vast AI, 檢索日期：2月 1, 2026， [https://vast.ai/article/nvidia-geforce-rtx-5090-specs-everything-you-need-to-know](https://vast.ai/article/nvidia-geforce-rtx-5090-specs-everything-you-need-to-know)  
28. Faster Training Throughput in FP8 Precision with NVIDIA NeMo | NVIDIA Technical Blog, 檢索日期：2月 1, 2026， [https://developer.nvidia.com/blog/faster-training-throughput-in-fp8-precision-with-nvidia-nemo/](https://developer.nvidia.com/blog/faster-training-throughput-in-fp8-precision-with-nvidia-nemo/)  
29. Floating-Point 8: An Introduction to Efficient, Lower-Precision AI Training \- NVIDIA Developer, 檢索日期：2月 1, 2026， [https://developer.nvidia.com/blog/floating-point-8-an-introduction-to-efficient-lower-precision-ai-training/](https://developer.nvidia.com/blog/floating-point-8-an-introduction-to-efficient-lower-precision-ai-training/)  
30. Train an LLM on NVIDIA Blackwell with Unsloth—and Scale for Production, 檢索日期：2月 1, 2026， [https://developer.nvidia.com/blog/train-an-llm-on-an-nvidia-blackwell-desktop-with-unsloth-and-scale-it/](https://developer.nvidia.com/blog/train-an-llm-on-an-nvidia-blackwell-desktop-with-unsloth-and-scale-it/)  
31. RTX 5090 (32GB VRAM) \- Full Fine-Tuning: What Can I Expect? : r/LocalLLaMA \- Reddit, 檢索日期：2月 1, 2026， [https://www.reddit.com/r/LocalLLaMA/comments/1m5ro7s/rtx\_5090\_32gb\_vram\_full\_finetuning\_what\_can\_i/](https://www.reddit.com/r/LocalLLaMA/comments/1m5ro7s/rtx_5090_32gb_vram_full_finetuning_what_can_i/)  
32. DreamerV3 and Muzero \- Medium, 檢索日期：2月 1, 2026， [https://medium.com/@kaige.yang0110/dreamerv3-and-muzero-0bcce4ec998b](https://medium.com/@kaige.yang0110/dreamerv3-and-muzero-0bcce4ec998b)  
33. Diffusion for World Modeling: Visual Details Matter in Atari \- NIPS, 檢索日期：2月 1, 2026， [https://proceedings.neurips.cc/paper\_files/paper/2024/file/6bdde0373d53d4a501249547084bed43-Paper-Conference.pdf](https://proceedings.neurips.cc/paper_files/paper/2024/file/6bdde0373d53d4a501249547084bed43-Paper-Conference.pdf)  
34. GAIA-2: A Controllable Multi-View Generative World Model for Autonomous Driving \- arXiv, 檢索日期：2月 1, 2026， [https://arxiv.org/html/2503.20523v1](https://arxiv.org/html/2503.20523v1)  
35. Multimodal LLMs for Autonomous Driving — Part 2: Transforming the Road with GAIA-1's Generative World Model | by Azam Kowalczyk | Medium, 檢索日期：2月 1, 2026， [https://medium.com/@az.tayyebi/multimodal-llms-for-autonomous-driving-part-2-transforming-the-road-with-gaia-1s-generative-b7cc06eea4e7](https://medium.com/@az.tayyebi/multimodal-llms-for-autonomous-driving-part-2-transforming-the-road-with-gaia-1s-generative-b7cc06eea4e7)  
36. wayveai/mile: PyTorch code for the paper "Model-Based ... \- GitHub, 檢索日期：2月 1, 2026， [https://github.com/wayveai/mile](https://github.com/wayveai/mile)  
37. eloialonso/diamond: DIAMOND (DIffusion As a Model Of eNvironment Dreams) is a reinforcement learning agent trained in a diffusion world model. NeurIPS 2024 Spotlight. \- GitHub, 檢索日期：2月 1, 2026， [https://github.com/eloialonso/diamond](https://github.com/eloialonso/diamond)  
38. How Diffusion Models Are Reimagining Game Environments: DIAMOND \- Deepgram, 檢索日期：2月 1, 2026， [https://deepgram.com/learn/diffusion-models-reimagining-game-environments-diamond](https://deepgram.com/learn/diffusion-models-reimagining-game-environments-diamond)  
39. OpenDriveLab/DriveAGI: A Collection of Foundation Driving Models by OpenDriveLab, 檢索日期：2月 1, 2026， [https://github.com/OpenDriveLab/DriveAGI](https://github.com/OpenDriveLab/DriveAGI)  
40. Geographic distribution of OpenDV-2K. Our dataset covers ample driving scenarios around the world. \- ResearchGate, 檢索日期：2月 1, 2026， [https://www.researchgate.net/figure/Geographic-distribution-of-OpenDV-2K-Our-dataset-covers-ample-driving-scenarios-around\_fig2\_382068104](https://www.researchgate.net/figure/Geographic-distribution-of-OpenDV-2K-Our-dataset-covers-ample-driving-scenarios-around_fig2_382068104)  
41. YouTube-8M: A Large and Diverse Labeled Video Dataset for Video Understanding Research \- Google Research, 檢索日期：2月 1, 2026， [https://research.google.com/youtube8m/](https://research.google.com/youtube8m/)  
42. 5 Ground-Breaking Datasets for Computer Vision Applications in 2026 \- CVAT, 檢索日期：2月 1, 2026， [https://www.cvat.ai/resources/blog/2026-datasets-for-computer-vision-applications](https://www.cvat.ai/resources/blog/2026-datasets-for-computer-vision-applications)  
43. CARLA UE5 \+ Ubuntu 22.04 \+ GeForce RTX 5090 graphics card \#9038 \- GitHub, 檢索日期：2月 1, 2026， [https://github.com/carla-simulator/carla/discussions/9038](https://github.com/carla-simulator/carla/discussions/9038)  
44. YouTube's first tutorial on DreamerV3. Paper, diagrams, clean code. \- Reddit, 檢索日期：2月 1, 2026， [https://www.reddit.com/r/reinforcementlearning/comments/1jgfp59/youtubes\_first\_tutorial\_on\_dreamerv3\_paper/](https://www.reddit.com/r/reinforcementlearning/comments/1jgfp59/youtubes_first_tutorial_on_dreamerv3_paper/)  
45. RTX 5090 \- What is the most up to date Model that can actually work? more details inside : r/LocalLLaMA \- Reddit, 檢索日期：2月 1, 2026， [https://www.reddit.com/r/LocalLLaMA/comments/1q6x3vx/rtx\_5090\_what\_is\_the\_most\_up\_to\_date\_model\_that/](https://www.reddit.com/r/LocalLLaMA/comments/1q6x3vx/rtx_5090_what_is_the_most_up_to_date_model_that/)  
46. Which models would I be able to run with RTX 5090 with 32GB Vram? \- Reddit, 檢索日期：2月 1, 2026， [https://www.reddit.com/r/LocalLLaMA/comments/1hkdzne/which\_models\_would\_i\_be\_able\_to\_run\_with\_rtx\_5090/](https://www.reddit.com/r/LocalLLaMA/comments/1hkdzne/which_models_would_i_be_able_to_run_with_rtx_5090/)  
47. Newb: what size model could I realistically run on a 4090 / 5090 : r/LocalLLaMA \- Reddit, 檢索日期：2月 1, 2026， [https://www.reddit.com/r/LocalLLaMA/comments/1iqdu1b/newb\_what\_size\_model\_could\_i\_realistically\_run\_on/](https://www.reddit.com/r/LocalLLaMA/comments/1iqdu1b/newb_what_size_model_could_i_realistically_run_on/)

[image1]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAbCAYAAACqenW9AAAAgklEQVR4XmNgGAVDAkQCsRYSnw2IzZH4cPAfCS+Civ1DSCPAYSBuBmIWILYF4i0MEE3qyIpwgd1AbI8uiA2cB2JTdEFs4AkQK6ALYgMfgZgXTSwCjQ8Gn4CYA01MByqOAm4A8QcgfsqAGnwgDAodOLAD4vVI/A4GiCKQiaAIGQV0BgDdjhlIpYmvhwAAAABJRU5ErkJggg==>