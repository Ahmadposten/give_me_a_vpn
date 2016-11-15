FROM ubuntu:14.04
MAINTAINER Ahmad Posten <ahmad.hassan@gmail.com>
RUN apt-get update && apt-get install -y openvpn wget
RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
RUN sysctl -p
RUN mkdir /etc/openvpn/easy-rsa
RUN cd /etc/openvpn
RUN wget https://github.com/OpenVPN/easy-rsa/archive/v2.2.0.tar.gz -O easy-rsa.tar.gz 
RUN tar xvzf easy-rsa.tar.gz -C /etc/openvpn/easy-rsa --strip-components=3 easy-rsa-2.2.0/easy-rsa/2.0/
RUN cd /etc/openvpn/easy-rsa 
RUN cp ~/vars /etc/openvpn/easy-rsa/vars
RUN source ./vars 
RUN ./clean-all
RUN ./build-dh
RUN /pkitool --initca & /pkitool --server server 
RUN cd keys & openvpn –genkey –secret ta.key 
RUN cp server.crt server.key ca.crt dh1024.pem ta.key ../../
RUN cp ~/clientvars ./ 
RUN source ./clientvars
RUN ./pkitool client 
RUN cp ~/server.conf ./ 
RUN service openvpn start 
RUN node create_account_and_send_stuff.js
RUN echo "The client is ready to run"


