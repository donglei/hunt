module kiss.socket.acceptor;

import kiss.event.base;
import kiss.event.loop;
import kiss.event.watcher;
import std.socket;


final class TCPSocket : Transport
{
    
    void setClose(){}
    void setData(){}

    void write(){}

protected:
    override void onRead(Watcher watcher){

    }

    override void onClose(Watcher watcher){

    }

    override void onWrite(Watcher watcher){

    }

private:
    TCPSocketWatcher _watcher;
}