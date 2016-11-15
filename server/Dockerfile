FROM ubuntu:14.04
MAINTAINER Ahmad Posten <ahmad.hassan@gmail.com>
RUN apt-get update && apt-get install -y openvpn wget zip iptables
RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
RUN sysctl -p
RUN mkdir /etc/openvpn/easy-rsa
RUN wget https://github.com/OpenVPN/easy-rsa/archive/v2.2.0.tar.gz -O easy-rsa.tar.gz 
RUN tar xvzf easy-rsa.tar.gz -C /etc/openvpn/easy-rsa --strip-components=3 easy-rsa-2.2.0/easy-rsa/2.0/
COPY config /etc/openvpn/config 
ADD config/server.conf /etc/openvpn/config
RUN cp /etc/openvpn/config/vars /etc/openvpn/easy-rsa/vars 
#RUN chown -R root:sudo /etc/openvpn
RUN chmod 777 -R   /etc/openvpn/ 
RUN mkdir /etc/openvpn/easy-rsa/keys
RUN . /etc/openvpn/easy-rsa/vars && /etc/openvpn/easy-rsa/clean-all && /etc/openvpn/easy-rsa/build-dh && /etc/openvpn/easy-rsa/pkitool --initca && /etc/openvpn/easy-rsa/pkitool --server server
RUN openvpn --genkey --secret ta.key 

RUN cd /etc/openvpn/easy-rsa && cp server.crt server.key ca.crt dh1024.pem ta.key ../../
RUN . /etc/openvpn/config/clientvars && /etc/openvpn/easy-rsa/pkitool client 
RUN cp /etc/openvpn/config/server.conf /etc/openvpn 
RUN mkdir newconfig 
RUN cp -r /etc/openvpn/config/* /etc/openvpn/easy-rsa/keys ta.key newconfig

COPY create_and_send_stuff.sh ./
RUN sh . ./create_and_send_stuff.sh 
RUN service openvpn start 
RUN echo "The client is ready to run copy the url above (can be used once) and add it as argument to the client --url"
