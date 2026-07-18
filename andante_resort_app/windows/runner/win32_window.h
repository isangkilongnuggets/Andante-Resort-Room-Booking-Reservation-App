#ifndef RUNNER_WIN32_WINDOW_H_
#define RUNNER_WIN32_WINDOW_H_

#include <windows.h>

#include <functional>
#include <memory>
#include <string>

// Label
// Label
// Label
class Win32Window {
 public:
  struct Point {
    unsigned int x;
    unsigned int y;
    Point(unsigned int x, unsigned int y) : x(x), y(y) {}
  };

  struct Size {
    unsigned int width;
    unsigned int height;
    Size(unsigned int width, unsigned int height)
        : width(width), height(height) {}
  };

  Win32Window();
  virtual ~Win32Window();

  // Label
  // Label
  // Label
  // Label
  // Label
  // Label
  bool Create(const std::wstring& title, const Point& origin, const Size& size);

  // Label
  bool Show();

  // Label
  void Destroy();

  // Label
  void SetChildContent(HWND content);

  // Label
  // Label
  HWND GetHandle();

  // Label
  void SetQuitOnClose(bool quit_on_close);

  // Label
  RECT GetClientArea();

 protected:
  // Label
  // Label
  // Label
  virtual LRESULT MessageHandler(HWND window,
                                 UINT const message,
                                 WPARAM const wparam,
                                 LPARAM const lparam) noexcept;

  // Label
  // Label
  virtual bool OnCreate();

  // Label
  virtual void OnDestroy();

 private:
  friend class WindowClassRegistrar;

  // Label
  // Label
  // Label
  // Label
  // Label
  static LRESULT CALLBACK WndProc(HWND const window,
                                  UINT const message,
                                  WPARAM const wparam,
                                  LPARAM const lparam) noexcept;

  // Label
  static Win32Window* GetThisFromHandle(HWND const window) noexcept;

  // Label
  static void UpdateTheme(HWND const window);

  bool quit_on_close_ = false;

  // Label
  HWND window_handle_ = nullptr;

  // Label
  HWND child_content_ = nullptr;
};

#endif  // Label
