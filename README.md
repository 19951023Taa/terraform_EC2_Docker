初期構築手順    
1.S3バケットを手動で作成    
2.tfbackendファイルのバケット名を作成したバケット名に変更する    
3.以下のコマンドでinit    
terraform init -reconfigure -backend-config=tfbackend    

EC2接続後以下手順    
1.yum install docker -y    
2.yum install git -y    
3.systemctl start docker    
4.git clone https://github.com/19951023Taa/terraform_container.git  
5.DockerfileのRDSの接続情報を更新    
6.docker build -t test-app .    
7.docker run -dit --name test-container -p 8080:8080 test-app    
8.EC2のパブリックIPに接続し、コンテナからRDSに接続できることを確認

<img width="802" alt="image" src="https://github.com/19951023Taa/terraform_EC2_Docker/assets/84821891/8e7725f6-5db7-4125-bb3d-c46425083775">
