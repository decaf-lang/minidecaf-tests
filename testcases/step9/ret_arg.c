// declared in runtime.h
int random();

int main() {
    // we did not call `init` to set a random seed
    // so the result is deterministic
    return random();
}
