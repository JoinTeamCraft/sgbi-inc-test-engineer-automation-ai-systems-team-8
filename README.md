# Robot Framework Python Automation Template

This is a clean template for a Robot Framework project with Python extensions.

## Structure

- **tests/**: Directory for test suites (organized by module).
- **resources/**: Directory for Robot keywords and locators.
- **python_lib/**: Directory for custom Python libraries.
- **config/**: Directory for configuration files.
- **results/**: Directory for test results.

## Usage

1. **Install Dependencies**:

   ```bash
   pip install robotframework robotframework-seleniumlibrary
   ```

2. **Implement Logic**:
   - Add locators to `resources/locators.robot`.
   - Add keywords to `resources/keywords.robot`.
   - Implement Python logic in `python_lib/`.

3. **Run Tests**:
    Run All tests
   ```bash
   robot --outputdir results tests/
   ```

   Run Specific Test Suite
```bash
robot --outputdir results tests/profile/TC_Verify_Update_Profile_Functionality.robot
```
   
### Resources (`resources/`)
- **keywords.robot**: Contains all reusable keywords including:
  - Launch Application
  - Navigate To Profile Page
  - Validate Update Profile
  - Update Profile Names
  - Verify Updated User Name

- **locators.robot**: Contains all locators for the application elements.

## Test Results

After running tests, reports are generated in the `results/` directory:
- `report.html` - Test execution report
- `log.html` - Detailed test execution log
- `output.xml` - Machine-readable test output


# Current Test Coverage

### Profile Management Tests
- **TC_Verify_User_Profile_Updation_name**: Tests updating user first and last names in the profile
  - Validates the update profile modal
  - Updates user names with valid values
  - Verifies updated names appear correctly
  - Resets names to original values
