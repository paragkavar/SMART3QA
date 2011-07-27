#import "Question.h"

@implementation Question

- (void) setQuestionId:(NSInteger *)input
{
    questionId = input;
}
- (NSInteger *) getQuestionId
{
    return questionId;
}

- (void) setAcceptedAnswer:(NSInteger *)input
{
    acceptedAnswer = input;
}
- (NSInteger *) getAcceptedAnswer
{
    return acceptedAnswer;
}

- (void) setUserId:(NSInteger *)input
{
    userId = input;
}
- (NSInteger *) getUserId
{
    return userId;
}

- (void) setTitle:(NSString *)input
{
    title = input;
}
- (NSString *) getTitle
{
    return title;
}

- (void) setBody:(NSString *)input
{
    body = input;
}
- (NSString *) getBody
{
    return body;
}

- (void) setCreated:(NSString *)input
{
    created = input;
}
- (NSString *) getCreated
{
    return created;
}

@end