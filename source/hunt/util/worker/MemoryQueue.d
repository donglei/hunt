module hunt.util.worker.MemoryQueue;

import hunt.util.worker.Task;
import hunt.util.worker.TaskQueue;

import hunt.logging.ConsoleLogger;

import core.atomic;
import core.sync.condition;
import core.sync.mutex;

import core.time;

import std.container.slist;

/**
 * It's a thread-safe queue
 */
class MemoryQueue : TaskQueue {
    private SList!Task _list;
    private Mutex _headLock;
    private Mutex _tailLock;

    shared int putCounter;
    shared int popCounter;

    /** Wait queue for waiting takes */
    private Condition _notEmpty;

    this() {
        _headLock = new Mutex();
        _tailLock = new Mutex();
        _notEmpty = new Condition(_headLock);
    }

    override bool isEmpty() {
        return _list.empty();
    }

    override Task pop() {
        _headLock.lock();
        scope (exit)
            _headLock.unlock();

        if(isEmpty()) {
            bool v = _notEmpty.wait(5.seconds);
            if(!v) {
                tracef("Timeout in 5 seconds. pop: %d, put: %d", popCounter, putCounter);
                return null;
            }
        }

        
        atomicOp!("+=")(popCounter, 1);

        Task task = _list.front();
        _list.removeFront();

        return task;
    }

    override void push(Task task) {
        _headLock.lock();
        scope (exit)
            _headLock.unlock();

        atomicOp!("+=")(putCounter, 1);

        _list.insert(task);

        _notEmpty.notifyAll();
    }
}

// class MemoryQueue : TaskQueue {
//     private SList!Task _list;
//     private Condition _condition;
//     private Mutex _mutex;

//     this() {
//         _mutex = new Mutex();
//         _condition = new Condition(_mutex);
//     }

//     bool isEmpty() {
//         return _list.empty();
//     }

//     Task pop() {
//         _mutex.lock();
//         scope(exit) {
//             _mutex.unlock();
//         }

//         if(isEmpty()) {
//             _condition.wait();
//         }

//         Task task = _list.front();
//         _list.removeFront();

//         return task;
//     }

//     void push(Task task) {
//         _mutex.lock();
//         scope(exit) {
//             _mutex.unlock();
//         }

//         _list.insert(task);

//         _condition.notifyAll();
//     }
// }