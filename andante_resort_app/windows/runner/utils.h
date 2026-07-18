#ifndef RUNNER_UTILS_H_
#define RUNNER_UTILS_H_

#include <string>
#include <vector>

// Label
// Label
void CreateAndAttachConsole();

// Label
// Label
std::string Utf8FromUtf16(const wchar_t* utf16_string);

// Label
// Label
std::vector<std::string> GetCommandLineArguments();

#endif  // Label
