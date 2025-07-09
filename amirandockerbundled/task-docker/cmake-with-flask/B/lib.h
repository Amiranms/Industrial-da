#include <string>


class ClassLib {
 public:
    void Set(int value);
    int Get() const;
    std::string PrintSomeHumor() const;

 private:
    int x_;
};
