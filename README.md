# sumo-with-cuda-docker-image
交通シミュレータである[SUMO](https://eclipse.dev/sumo/)の環境+GPU環境(cuda)を構築するためのDockerfileです。

## 環境構築方法
1. はじめに、GPUを持つ計算機上でDockerをインストールしておきます。
以下のコマンドでDocker composeコマンドがインストールされているか確認してください。   
`$ docker-compose version`
2. また、計算機にnvidiaのドライバーをインストールしておきます。
   以下のコマンドでインストールされているか確認してください。  
   `$ nvidia-smi`  
4. 以下のコマンドでContainerを起動できます。  
`
$ docker-compose build
`  
`
$ docker-compose up
`
5. 以下でimageと起動しているコンテナを確認してください  
`$ docker images`  
`$ dokcer ps` 

6. Containerの削除は以下のコマンドになります。  
`
$docker-compose down
`
## 環境概要
以下のコマンドをコンテナ内で確認してください。sumoとcudaが使えることを確認します。
1. 以下のコマンドでsumo0がsumoのver.0.32のコマンドであることがわかります。  
`
$sumo0 --version
`  
また、sumoはsumoのlatest-versionとなっています。  
`
$sumo --version 
`  
2. 以下でGPU(cuda)が使えるかどうか確認してください。  
`$python3`  
  `import torch`  
  `print(torch.cuda.is_available())`  
Trueと出力されれば、GPUが使える環境にあります。
